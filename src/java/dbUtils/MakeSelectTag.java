package dbUtils;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.*;

public class MakeSelectTag {

    public static String makeSelect(DbConn dbc, String selectName, String sql, String selectedElementID, String initial, String id, String name) {
        String selected = "selected = 'selected'";
        String out = "\n\n<select name = '" + selectName + "'>\n";

        try {
            PreparedStatement stmt = dbc.getConn().prepareStatement(sql);
            ResultSet results = stmt.executeQuery();

            //puts a pre-selected choice on first rendering of dropdown            
            out += "   <option value = '0'>";
            out += initial + "</option>\n";

            //while there are more rows/records (ex. jedrick, david, john, etc.)
            while (results.next()) {

                //allows for persistence
                if (results.getString(id).equals(selectedElementID)) {
                    out += "   <option value = '" + selectedElementID + "'" + selected + ">";
                    out += results.getString(name) + "</option>\n";
                } else {
                    out += "   <option value = '" + results.getString(id) + "'>";
                    out += results.getString(name) + "</option>\n";
                }
            }
            //close select tag
            out += "</select>\n\n";

            return out;

        } catch (Exception e) {
            return "Exception in MakeSelectTag.makeSelect(). Partial output: " + out + ". Error: " + e.getMessage();
        }

    }

    public static SelectOptionList makeSelectJSON(DbConn dbc, String id, String name, String sql, String numSQL, String numName) {

        SelectOptionList list = new SelectOptionList(0);
        PreparedStatement stmt = null;
        ResultSet results = null;

        try {

            //execut the numSQL to get the number of players
            stmt = dbc.getConn().prepareStatement(numSQL);
            results = stmt.executeQuery();
            
            //puts number of players in the constructor for the SelectOptionList class to create array of SelectOption
            if (results.next()) {
                int num = results.getInt(numName);
                list = new SelectOptionList(num);
            }

            //now execute sql to add each player to the list of players
            stmt = dbc.getConn().prepareStatement(sql);
            results = stmt.executeQuery();

            while (results.next()) {

                SelectOption so = new SelectOption("", "");

                try {
                    so.id = FormatUtils.formatInteger(results.getObject(id));
                    so.name = FormatUtils.formatString(results.getObject(name));

                } catch (Exception e) {}

                list.addOption(so);

            }
        } catch (Exception e) {
        }

        return list;
    }

}
