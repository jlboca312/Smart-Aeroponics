/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Registration;

import model.Player.*;

/**
 *
 * @author jedrickboca
 */
public class StringData {

    public String registrationId = "";
    public String playerName = ""; //foreign key
    public String tournamentName = ""; //foreign key
    public String eventType = "";
    public String donation = "";
    public String specialNeeds = "";
    public String errorMsg = ""; // this field is used, for example, to hold db error while attempting login.

    public int getCharacterCount(){
        String S = this.registrationId + this.playerName + this.tournamentName + this.eventType + this.donation + this.specialNeeds;
        
        return S.length();
    }
    
    public String toString() {
        return "Player Name:" + this.playerName
                + ", Tournament Name:" + this.tournamentName 
                + ", Event Type:" + this.eventType
                + ", Donation:" + this.donation
                + ", Special Needs:" + this.specialNeeds
                + ", errorMsg:" + this.errorMsg;
    }
    
    

}
