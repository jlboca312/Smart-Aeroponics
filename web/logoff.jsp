<%
    session.invalidate();
    try {
        /**
         * Once user hits 'Log Off' button, they will get sent to this jsp page,
         * which just redirects them to the index.jsp, essentially logging them off
         */
        response.sendRedirect("index.jsp");  
    } catch (Exception e) {
        System.out.println("**** Exception was thrown in logoff.jsp: " + e.getMessage());
    }
%>

