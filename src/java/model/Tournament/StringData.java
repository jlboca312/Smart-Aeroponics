/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Tournament;

/**
 *
 * @author jedrickboca
 */
public class StringData {
    
    public String tournamentID = "";
    public String tournamentName = "";
    public String eventDate = "";
    public String tournamentDesc = "";
    public String errorMsg = ""; // this field is used, for example, to hold db error while attempting login.
    
    public int getCharacterCount(){
        String S = this.tournamentID + this.tournamentName + this.eventDate + this.tournamentDesc + this.errorMsg;
        
        return S.length();
    }

    public String toString() {
        return "Player Id:" + this.tournamentID
                + ", Player Name:" + this.tournamentName 
                + ", Email Address:" + this.eventDate
                + ", Password:" + this.tournamentDesc
                + ", errorMsg:" + this.errorMsg;
    }
    
}
