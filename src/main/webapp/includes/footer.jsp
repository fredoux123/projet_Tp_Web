<%@page import="java.util.ResourceBundle"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ResourceBundle bundle = (ResourceBundle) session.getAttribute("bundle");
%>

<footer class="bg-dark text-white text-center p-3 mt-auto">
    © 2025 <%= bundle.getString("footer.brand") %>. <%= bundle.getString("footer.rights") %>
</footer>



