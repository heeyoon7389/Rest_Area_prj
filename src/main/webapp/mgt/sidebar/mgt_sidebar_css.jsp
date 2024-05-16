<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
	
	.bgColor{background-color: #F5F6FA;}
	
	.sideUl { /* 좌측 사이드바 */
	  list-style-type: none;
	  padding: 0px;
	  margin: 0px;
	  width: 225px;
	  height: 100%;
	  background: #101924;
	  overflow: auto;
	  position: fixed;
	}
	
	.sideSelect{color:#7F8DFF;}
	
	.sideDisSelect{color: #66799B;}

	.sideText{ /* 사이드바 글자 */
	  text-decoration: none;
	  padding: 5px;
	  display: block;
	  font-weight: bold;  
	}
	
	.sideText:hover { /* 커서 올렸을때 색 */
	  color: #7F8DFF;
	}
	
	#mainFrame { /* 중앙 메인화면 프레임 */
	  margin-left: 225px;
	  padding-top: 5px;
	  height: 100%;
	  /*background-color: #FFFFFF;*/
	}
	
	.topMenu{ /* 사이드바 대분류메뉴 글씨 */
		font-size: 30px;
		padding-left: 10px;
	}
	
	.bottomMenu{ /* 사이드바 소분류메뉴 글씨 */
		font-size: 18px;
		padding-left: 25px;
	}
	
	#frmBackground{ /* 중앙 최상단 타이틀바 프레임(밑줄긋기용) */
		border-bottom: 3px solid #CECECE;
		margin-bottom: 20px;
	}
	
	#currentTopMenuName{ /* 중앙 최상단 타이틀바 > 대분류 글씨 */
		font-size: 40px;
		font-weight: bold;
		padding-left: 15px;
	}
	
	#currentBottomMenuName{ /* 중앙 최상단 타이틀바 > 소분류 글씨 */
		font-size: 30px;
		font-weight: bold;
	}
	
	/* ~~~~~~~~~~~ 여기부터 내용부분 css ~~~~~~~~~~~ */
	
	.tableFrm{ /* 테이블 div */
		margin-left: 1%;
		margin-right: 1%;
	}
	
	.Frame1{ /* 위쪽 노선명~ 들어가있는 div */
		width: 100%;
		height: auto;
		padding: 15px;
		text-align: center;
		font-size: 15px;
		font-weight: bold;
		background-color: #E0E0E0;
	}
	
	.Frame2{ /* 아래쪽 버튼 들어가있는 div */
		width: 100%;
		height: auto;
		padding: 15px;
		padding-right: 18%;
		text-align: center;
		background-color: #E0E0E0;
		position: fixed;
		bottom: 0;
	}
	
	.restAreaTable{ /* 메인 테이블 */
		width: 100%;
		margin-top: 15px;
		border: 1px solid #B1B1B1;
	}
	
	th{
		height: 40px;
		border: 1px solid #B1B1B1;
		background-color: #D0D0D0;
		padding: 5px;
	}
	
	tr, td{
		height: 35px;
		border: 1px solid #B1B1B1;
		padding: 5px;
	}
	
	.menuBtn{ /* 메뉴 관리 버튼 */
		width: 120px;
		height: 39px;
		border: 1px solid #779BB2;
		background-color: #779BB2;
		border-radius: 5px;
		color: white;
	}
	
	.shopBtn{ /* 매장/메뉴 관리 버튼 */
		width: 120px;
		height: 39px;
		border: 1px solid #74A086;
		background-color: #74A086;
		border-radius: 5px;
		color: white;
	}
	
	.areaAmenitieBtn{ /* 휴게소 편의시설 관리 버튼 */
		width: 170px;
		height: 39px;
		border: 1px solid #A87873;
		background-color: #A87873;
		border-radius: 5px;
		color: white;
	}
	
	.allAmenitieBtn{
		width: 120px;
		height: 39px;
		border: 1px solid #C3AFAD;
		background-color: #C3AFAD;
		border-radius: 5px;
		color: white;
	}
	
	.petrolBtn{
		width: 120px;
		height: 39px;
		border: 1px solid #9896B8;
		background-color: #9896B8;
		border-radius: 5px;
		color: white;
	}
	
	/* 게시판 */
	.boardTitle:hover{cursor:pointer;}
	.noDeco{text-decoration: none; color:black;}
	
	/* 대시보드 */
	#content{width:1600px; height:2000px; margin:0px auto;}
	
	#siteView{position:absolute;width:770px; height:500px; background-color: #ffffff;}
	#memberVari{position:absolute;width:770px; height:500px; margin-left:790px; background-color: #ffffff;float: right;}
	
	#raView{position:absolute;width:770px; height:400px; margin-top:520px; background-color: #ffffff;}
	#raReview{position:absolute;width:770px; height:400px; margin-top:520px; margin-left:790px; background-color: #ffffff;}
	
	#inquiryList{position:absolute;width:770px; height:400px; margin-top:940px; background-color: #ffffff;}
	#reportList{position:absolute;width:770px; height:400px; margin-top:940px; margin-left:790px; background-color: #ffffff;}
	
	.subtitle{font-size: 25px; font-weight: bold; color:#364A63; padding: 5px;}

	.selecDate{text-align: right; margin-right:10px; font-size:15px;}
	
	.graph{width:750px; height:420px;}
	
	.borderBot{border-left: none; border-right: none; border-top: none;}
	.tableC1{width: 150px;}
	.tableC2{width: 450px;}
	.tableC2_2{width: 400px;}
	.tableC3{width: 150px;}
	.marginTop{margin-top: 10px;}
	.marginCenter{margin:0px auto;}
	.fontRed{color:#ff0000;}
	.fontBlue{color:#0000ff;}

</style>
	