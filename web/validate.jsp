<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>Simple Validation</title>
        <style>
            .error {
                color:red;
            }
        </style>
    </head>

    <%

        String strLastName = "";
        String strAge = "";
        String lastNameErrorMsg = ""; // be optimistic
        String ageErrorMsg = ""; // dont show an error upon 1st rendering
        String msg = ""; // this is an overall messsage (beyond field level validation)
        if (request.getParameter("lastName") != null) {
            strLastName = request.getParameter("lastName");
            if (strLastName.length() == 0) {
                lastNameErrorMsg = "Last Name is a required field";
            }
            strAge = request.getParameter("age");
            try {
                int i = Integer.parseInt(strAge);
            } catch (Exception e) {
                ageErrorMsg = "Please enter a numeric age.";
            }
            String allErrors = lastNameErrorMsg + ageErrorMsg;
            if (allErrors.length() == 0) {
                msg = "Congratulations for filling out the form sucessfully.";
            } else {
                msg = "Please try again.";
            }
        }

    %>
    <body>
        <h2>Simple Validation: last name is required, age must be a whole number</h2>
        <form action="validate.jsp" method="get">
            Please enter your last name 
            <input name="lastName" value="<%out.print(strLastName);%>"/> 
            <span class="error"><%=lastNameErrorMsg%></span> 
            <br/>
            Please enter your age 
            <input name ="age" value="<%out.print(strAge);%>"/>
            <span class="error"><%=ageErrorMsg%></span>
            <br/><br/>
            <input type="submit" value="click me"/>
            <br/><br/>
            <%=msg%>
        </form>
    </body>
</html>