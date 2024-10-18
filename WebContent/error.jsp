<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오류 발생</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #ffffff;
            font-family: Arial, sans-serif;
        }
        .error-container {
            text-align: center;
            background-color: #22e322;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            max-width: 600px;
        }
        h1 {
            color: #E6F9E6;
        }
        p {
            color: #E6F9E6;
        }
        a {
            text-decoration: none;
            color: #000000; /* 링크 색상을 검정색으로 변경 */
        }
        .logo {
            width: 400px; /* 이미지 크기를 조금 더 키움 */
            height: auto;
            margin-bottom: 20px;
        }
    </style>
    <script>
        // 페이지 로드 시 alert을 표시
        window.onload = function() {
            alert("에러가 났네요. 좀 있다가 다시 하세요.");
        }
    </script>
</head>
<body>
    <div class="error-container">
        <img src="images/error_logo.png" alt="Error Logo" class="logo">
        <h1>정보를 불러올수 없어요.</h1>
        <p>항상 이용해주셔서 감사합니다.</p>
        
        <p><a href="index.jsp">홈으로 돌아가기</a></p>
    </div>
</body>
</html>
