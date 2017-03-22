
package model.Registration;

/** 
 * Create an enhanced StringData class that represents an associative record joined with user and "other" – 
 * you only need to create properties for the fields you will be showing in search.html.
 */
public class EnhancedStringData {

    public String playerName = ""; //foreign key
    public String tournamentName = ""; //foreign key
    public String eventType = "";
    public String donation = "";
    public String specialNeeds = "";
    public String errorMsg = ""; // this field is used, for example, to hold db error while attempting login.
}
