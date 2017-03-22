/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Player;

/**
 *
 * @author jedrickboca
 */
public class StringData {

    public String playerId = "";
    public String playerName = "";
    public String emailAddress = "";
    public String pswd = "";
    public String skillLevel = "";
    public String roleName = "";
    public String errorMsg = ""; // this field is used, for example, to hold db error while attempting login.

    public int getCharacterCount(){
        String S = this.playerId + this.playerName + this.emailAddress + this.pswd + this.skillLevel + this.roleName;
        
        return S.length();
    }
    
    public String toString() {
        return "Player Id:" + this.playerId
                + ", Player Name:" + this.playerName 
                + ", Email Address:" + this.emailAddress
                + ", Password:" + this.pswd
                + ", Skill Level:" + this.skillLevel
                + ", Role Name:" + this.roleName
                + ", errorMsg:" + this.errorMsg;
    }
    
    

}
