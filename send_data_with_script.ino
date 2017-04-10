#include <Console.h>
#include <Bridge.h>
#include <FileIO.h>
#include <OneWire.h>
#include <DHT.h>

// photocell sensor
const int pResistor = A0; // Photoresistor at Arduino analog pin A0
int lightValue;          // Store value from photoresistor (0-1023)

// air temp and humidity sensor
#define DHTPIN 2 
#define DHTTYPE DHT22   // DHT 22  (AM2302), AM2321
DHT dht(DHTPIN, DHTTYPE); // initialize dht sensor

// water temp sensor
int DS18S20_Pin = 4; //DS18S20 Signal pin on digital 2
char tmpstring[10];
OneWire ds(DS18S20_Pin);  // on digital pin 2
const unsigned long sensorLoopTime = 2000;
unsigned long sensorTime;

// water float sensor 1
const byte switchPin = 8;
byte oldSwitchState = HIGH;  // assume switch open because of pull-up resistor
const unsigned long debounceTime = 10;  // milliseconds
unsigned long switchPressTime;  // when the switch last changed state

// Water float sensor 1
// const byte switchPin1 = 8;

// Runs once on start
void setup() {
    Bridge.begin();
    Serial.begin(9600);
    FileSystem.begin();
    pinMode (switchPin, INPUT_PULLUP);
    Bridge.put("WATER_LEVEL","HIGH");
}

// Runs constantly once arduino boots
void loop() {
  //Create string for debugging to console to file
  String dataString;
  
  // Water float sensor code
  // see if float is open or closed
  if (digitalRead (switchPin) == HIGH){
    Bridge.put("WATER_LEVEL_1","HIGH");
    dataString+= "water_level_1:'high'";
  } else {
    Bridge.put("WATER_LEVEL_1","LOW");    
    dataString+= "water_level_1:'low'";
  }

  // water temp sensor code
  float temperature = getTemp();
  int tmp = (int) temperature;
  String waterTempStr = String(tmp);
  Bridge.put("WATER_TEMP",waterTempStr);
  dataString+= ",water_temp:'";
  dataString+= tmp;
  dataString+= "'";

  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float humidity = dht.readHumidity();
  // Read temperature as Fahrenheit (isFahrenheit = true)
  float fahrenheit = dht.readTemperature(true);

  // Check if any reads failed and exit early (to try again).
  if (isnan(humidity) || isnan(fahrenheit)) {
    Serial.println("Failed to read from DHT sensor!");
    Bridge.put("HUMIDITY","-999");
    Bridge.put("AIR_TEMP","-999");
  } else {
    String humidityStr = String((int)humidity);
    String airTempStr = String((int)fahrenheit);
    Bridge.put("HUMIDITY",humidityStr);
    Bridge.put("AIR_TEMP",airTempStr);
  }

  dataString+= ",humidity:'";
  dataString+= (int) humidity;
  dataString+= "'";

  dataString+= ",air_temp:'";
  dataString+= (int) fahrenheit;
  dataString+= "'";

  // photocell code
  lightValue = analogRead(pResistor);
  String lightLevelStr = String(lightValue);
  Bridge.put("LIGHT_LEVEL",lightLevelStr);

  dataString+= ",light_level:'";
  dataString+= lightValue;
  dataString+= "'";
  
  Serial.println(dataString);
  //Serial.println("Launching python script");
  
  //Process p;
  //p.runShellCommandAsynchronously("/usr/bin/python /mnt/sd/arduino/tcp_client_3.py");
  //p.run();

 delay(5000); //time to sleep
}

float getTemp(){
  //returns the temperature from one DS18S20 in DEG Celsius

  byte data[12];
  byte addr[8];

  if (!ds.search(addr)) {
      //no more sensors on chain, reset search
      ds.reset_search();
      return -999;
  }

  if (OneWire::crc8( addr, 7) != addr[7]) {
      Serial.println("CRC is not valid!");
      return -999;
  }

  if (addr[0] != 0x10 && addr[0] != 0x28) {
      Serial.print("Device is not recognized");
      return -999;
  }

  ds.reset();
  ds.select(addr);
  ds.write(0x44,1); // start conversion, with parasite power on at the end

  byte present = ds.reset();
  ds.select(addr);    
  ds.write(0xBE); // Read Scratchpad

  for (int i = 0; i < 9; i++) { // we need 9 bytes
    data[i] = ds.read();
  }

  ds.reset_search();

  byte MSB = data[1];
  byte LSB = data[0];

  float tempRead = ((MSB << 8) | LSB); //using two's compliment
  float TemperatureSum = tempRead / 16;

  return (TemperatureSum * 18 + 5)/10 + 32;
}
