<%@ page import="Project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>

<%
    String course = request.getParameter("course");
    String branch = request.getParameter("branch");
    String rollNo = request.getParameter("rollNo");
    String name = request.getParameter("name");
    String fatherName = request.getParameter("fatherName");
    String gender = request.getParameter("gender");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        // Get the connection from ConnectionProvider
        con = ConnectionProvider.getCon();

        // Prepare the SQL statement
        ps = con.prepareStatement(
            "INSERT INTO student (course, branch, rollNo, name, fatherName, gender) VALUES (?, ?, ?, ?, ?, ?)"
        );

        // Set the values for the prepared statement
        ps.setString(1, course);
        ps.setString(2, branch);
        ps.setString(3, rollNo);
        ps.setString(4, name);
        ps.setString(5, fatherName);
        ps.setString(6, gender);

        // Execute the update
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            // If the insert is successful, redirect to the admin home page
            response.sendRedirect("adminHome.jsp");
        } else {
            out.println("Insertion failed.");
        }

    } catch (Exception e) {
        // Print the stack trace for debugging
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
