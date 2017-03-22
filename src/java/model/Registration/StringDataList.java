package model.Registration;

/**
 * Create a StringDataList class that contains an array of these (enhanced
 * Associative) StringData objects. The StringDataList object also needs a
 * database error field so that it can communicate issues to the HTML page.
 *
 */
public class StringDataList {

    public EnhancedStringData[] registrationList = null;
    public int listSize = 0;
    private int addIndex = 0;
    public String dbError = "";
    
    public StringDataList(int listSize) {
        this.listSize = listSize;
        this.registrationList = new EnhancedStringData[listSize];
    }

    public boolean addRegistration(EnhancedStringData registration) {
        if (this.addIndex < this.listSize) {
            this.registrationList[addIndex] = registration;
            this.addIndex++;
            return true;
        } else {
            System.out.println("***** StringDataList: Attempt to add registration number " +
                    this.addIndex + " to registration list of size " + this.listSize);
            return false;
        }
    }
}
