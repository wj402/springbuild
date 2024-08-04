<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">공지사항 목록</h1>
<p class="mb-4">교육과정과 교육정책 전반의 정보를
    통합 제공하고, 협업 소통을 지원하는
    교육정보 통합 지원 서비스입니다 <a target="_blank"
                                                               href="https://localhost:8080"> &nbsp;&nbsp; 학습시스템 홈페이지</a>.</p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <div class="m-0 font-weight-bold text-primary">
            <p>학습시스템 공지사항</p>
            <span class="text-dark">학습시스템 공지사항은 20년이 넘은 공공 교육 정보 서비스입니다</span>
        </div>
        <sec:authorize access="isAuthenticated()">
        <div class="float-right">
            <a href="/board/register">
                <button class="btn btn-info">글쓰기</button>
            </a>
        </div>
        </sec:authorize>
    </div>
    <div class="card-body">

        <div>
            <select name='typeSelect'>
                <option value="" >--</option>
                <option value="T" ${cri.typeStr == 'T' ? 'selected' : ''} >제목</option>
                <option value="C" ${cri.typeStr == 'C' ? 'selected' : ''} >내용</option>
                <option value="W" ${cri.typeStr == 'W' ? 'selected' : ''} >작성자</option>
                <option value="TC" ${cri.typeStr == 'TC' ? 'selected' : ''} >제목 OR 내용</option>
                <option value="TW" ${cri.typeStr == 'TW' ? 'selected' : ''} >제목 OR 작성자</option>
                <option value="TCW" ${cri.typeStr == 'TCW' ? 'selected' : ''} >제목 OR 내용 OR 작성자</option>
            </select>
            <input type='text' name='keywordInput' value="<c:out value="${cri.keyword}" />" />
            <button class="btn btn-default searchBtn" style="border: 1px solid #333; height: 30px; line-height: 20px;">검색</button>
        </div>

        <div class="table-responsive">

            <form id="actionForm" method="get" action="/board/list">
                <input type="hidden" name="pageNum" value="${cri.pageNum}">
                <input type="hidden" name="amount" value="${cri.amount}">
                <c:if test="${cri.types != null && cri.keyword != null }">
                    <c:forEach var="type" items="${cri.types}">
                        <input type="hidden" name="types" value="${type}">
                    </c:forEach>
                    <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}" />" />
                </c:if>
            </form>

            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>날짜/시간</th>
                    <th>업데이트 시간</th>
                </tr>
                </thead>
                <tbody class="tbody" style="cursor: pointer; ">
                <c:forEach var="board" items="${list}">
                    <tr data-bno="${board.bno}">
                        <td><c:out  value="${board.bno}"/></td>
                        <td><c:out  value="${board.title}"/></td>
                        <td><c:out  value="${board.writer}"/></td>
                        <td><c:out  value="${board.regDate}"/></td>
                        <td><c:out  value="${board.updateDate}"/> 날짜</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div>
                <ul class="pagination">

                    <c:if test="${pageMaker.prev}">
                        <li class="page-item">
                            <a class="page-link" href="${pageMaker.startPage -1}}" tabindex="-1" >이전</a>
                        </li>
                    </c:if>

                    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
                        <li class="page-item ${cri.pageNum == num ? 'active' : ''}">
                            <a class="page-link" href="${num}" >${num}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${pageMaker.next}">
                        <li class="page-item">
                            <a class="page-link" href="${pageMaker.endPage}}">다음</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<div id="myModal" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Modal body text goes here.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"> 닫기</button>
                <button type="button" class="btn btn-primary">저장하기</button>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>

<script>
    const result = '${result}'

    const myModal = new bootstrap.Modal(document.getElementById('myModal'))

    console.log(myModal)

    if(result){
        myModal.show()
    }

    const actionForm = document.querySelector("#actionForm")

    document.querySelector('.tbody').addEventListener("click", (e) => {

        const target = e.target.closest("tr")
        const bno = target.dataset.bno

        const before = document.querySelector("#clonedActionForm")

        if(before) {
            before.remove()
        }

        const clonedActionForm = actionForm.cloneNode(true)
        clonedActionForm.setAttribute("action", `/board/read/\${bno}`)
        clonedActionForm.setAttribute("id", 'clonedActionForm')

        console.log(clonedActionForm)
        document.body.appendChild(clonedActionForm)

        clonedActionForm.submit()

    }, false)

    document.querySelector(".pagination").addEventListener("click", (e) => {

        e.preventDefault()
        const target = e.target
        console.log(target)

        const targetPage = target.getAttribute("href")
        console.log(targetPage)

        actionForm.setAttribute("action", "/board/list")
        actionForm.querySelector("input[name='pageNum']").value = targetPage
        actionForm.submit()

    }, false)

    document.querySelector(".searchBtn").addEventListener("click",(e)=> {
        e.preventDefault()
        e.stopPropagation()

        const selectObj = document.querySelector("select[name='typeSelect']")

        const selectValue =selectObj.options[selectObj.selectedIndex].value

        console.log("selectValue----------")
        console.log(selectValue)

        const arr = selectValue.split("")

        console.log(arr)

        //actionForm에 hidden태그로 만들어서 검색 조건 추가
        // 페이지 번호도 1페이지로
        // amount도 새로 만들자.

        let str = ''

        str = `<input type="hidden" name='pageNum' value=1>`
        str += `<input type="hidden" name='amount' value=${cri.amount}>`

        if(arr && arr.length > 0) {
            for (const type of arr) {
                str += `<input type="hidden" name='types' value=\${type}>`
            }
        }
        const keywordValue = document.querySelector("input[name='keywordInput']").value
        str += `<input type="hidden" name='keyword' value=\${keywordValue}>`
        actionForm.innerHTML = str

        //console.log(str)

        actionForm.submit()
    })

</script>

<%@include file="../includes/end.jsp"%>