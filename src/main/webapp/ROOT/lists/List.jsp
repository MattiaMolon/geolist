<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Geolist - ${name}</title>
        <link rel="icon" href="/ROOT/logos/logo.png">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" crossorigin="anonymous">
        <style><%@include file="/ROOT/css/main.css" %></style>
    </head>

    <body>

        <!--navbar-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container-fluid">

                <!--logo e titolo del sito-->
                <a class="navbar-brand" href="/">
                    <img src="<c:url value="/ROOT/logos/logo-orizzontale.png"/>" height="40" width="120" alt="logo">
                </a>

                <!--bottone che serve per la navabar quando collassa, viene visualizzato solamente quando la finestra raggiunge
                la dimensione specificata nel target-->
                <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#collapse-target" >
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!--tutto quello che voglio fare collassare lo metto all'interno di questo div-->
                <div class="collapse navbar-collapse" id="collapse-target">

                    <!--lista degli elementi cliccabili-->
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="/">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/ViewAccount">Profile</a>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>

        <div class="container padding-top2">

            <!--titolo-->
            <div class="row padding-top">
                <div class="col-12">
                    <div class="display-4 font-25 my-2">
                        <input type="text" id="title-box" name="name" value="${name}" /><br>
                        <small class="font-15 mr-sm-2">${category}</small>
                    </div>
                </div>
            </div>
            <hr class="padding-bottom">

            <!--container per gli elementi che hai-->
            <c:if test="${listItems.size() != 0}">
                <div class="display-4 font-15 my-2 padding-bottom text-center">
                    Elements already in your list:
                </div>
                <div class="container testimonial-group">
                    <div class="row flex-row flex-nowrap card-deck">

                        <c:forEach var="item" items="${listItems}">
                            <!--elenco di carte-->
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-3">
                                <div class="card m-0">
                                    <form method="POST" action="<c:url value="/List">
                                              <c:param name="listID" value="${listID}"/>
                                              <c:param name="itemID" value="${item.getId()}"/>
                                              <c:param name="action" value="removeItem"/>
                                          </c:url>" id="card-trash-solo">
                                        <button type="submit" value="Remove" class="btn btn-danger btn-md my-2"><i class="far fa-trash-alt"></i></button>
                                    </form>
                                    <img class="card-img-top border" src="<c:url value="/ItemServlet">
                                             <c:param value="${item.getId()}" name="itemID"/>
                                             <c:param value="retrieveImage" name="action"/>
                                         </c:url>">
                                    <div class="card-body">
                                        <h4 class="card-title">${item.getName()}</h4>
                                        <p class="card-text">${item.getNote()}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>


                    </div>
                </div>
                <hr>
            </c:if>

            <!--container per gli elementi che puoi aggiungere nella lista-->
            <div class="display-4 font-15 my-2 padding-bottom padding-top text-center">
                Elements you can add in your list:
            </div>
            <div class="container testimonial-group padding-bottom">
                <ul class="list-group list-group-flush border" id="listItems">

                    <c:forEach var="item" items="${allItems}">
                        <li class="list-group-item" >${item.getName()}
                            <a style="display: inline-block;" href="<c:url value="/ItemServlet">
                                   <c:param name="itemID" value="${item.getId()}"/>
                                   <c:param name="action" value="viewItem"/>
                               </c:url>">
                                <button class="btn btn-outline-info btn-md ml-2 my-2 mr-2"><i class="far fa-eye"></i></button>
                            </a>
                            <form style="display: inline-block;" class="form-inline" method="POST" action="<c:url value="/List">
                                      <c:param name="listID" value="${listID}"/>
                                      <c:param name="itemID" value="${item.getId()}"/>
                                      <c:param name="action" value="addItem"/>
                                  </c:url>">
                                <button type="submit" class="btn btn-outline-success btn-md my-2"><i class="fas fa-plus"></i></button>
                            </form>
                        </li>
                    </c:forEach>

                </ul>
            </div>
            <hr>

            <!--aggiungi descrizione-->
            <div class="row padding-bottom">
                <div class="col-12 text-center">
                    <div class="display-4 font-15 my-2">
                        add a/modify the description:
                    </div><br>
                </div>
                <div class="col-12 text-center">
                    <input type="text" id="description-box" name="description" value="${desc}" />
                </div>
            </div>
            <hr>
        </div>


        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
    </body>
</html>