<%@ page import="java.sql.*" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 로그인한 사용자의 권한 및 세션 확인
    String userType = (String) session.getAttribute("usertype");
    String currentUsername = (String) session.getAttribute("username");

    // 세션이 없는 경우 로그인 페이지로 이동
    if (currentUsername == null) {
        response.sendRedirect("login.jsp?message=" + Encode.forUriComponent("로그인이 필요합니다."));
        return;
    }

    // 삭제할 게시글의 ID를 가져옴
    String idParam = request.getParameter("id");
    int id = 0;

    // ID 값이 잘못된 경우를 대비하여 예외 처리
    try {
        if (idParam != null) {
            id = Integer.parseInt(idParam);
        } else {
            out.println(Encode.forHtml("유효하지 않은 게시글 ID입니다."));
            return;
        }
    } catch (NumberFormatException e) {
        out.println(Encode.forHtml("유효하지 않은 형식의 ID입니다."));
        return;
    }

    // 데이터베이스 연결 및 삭제 쿼리 실행
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 데이터베이스 연결
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopping-cart?useUnicode=true&characterEncoding=utf8", "root", "1234");

        // 삭제하려는 게시글의 작성자가 현재 로그인한 사용자인지 확인
        String checkAuthorSql = "SELECT author FROM board WHERE id = ?";
        pstmt = conn.prepareStatement(checkAuthorSql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String author = rs.getString("author");

            // 게시글 작성자와 현재 사용자가 동일하지 않고, 관리자가 아닌 경우 삭제 불가 처리
            if (!author.equals(currentUsername) && !userType.equals("admin")) {
                response.sendRedirect("boardList.jsp?message=" + Encode.forUriComponent("해당 게시글을 삭제할 권한이 없습니다."));
                return;
            }

            // 작성자가 맞으면 삭제 쿼리 실행
            String deleteSql = "DELETE FROM board WHERE id = ?";
            pstmt = conn.prepareStatement(deleteSql);
            pstmt.setInt(1, id);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // 삭제 성공
                response.sendRedirect("boardList.jsp?message=" + Encode.forUriComponent("게시글이 삭제되었습니다."));
            } else {
                // 삭제할 데이터가 없는 경우
                out.println(Encode.forHtml("삭제할 게시글이 없습니다."));
            }
        } else {
            out.println(Encode.forHtml("해당 게시글이 존재하지 않습니다."));
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println(Encode.forHtml("게시글 삭제 중 오류가 발생했습니다: " + e.getMessage()));
    } finally {
        // 자원 정리
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
