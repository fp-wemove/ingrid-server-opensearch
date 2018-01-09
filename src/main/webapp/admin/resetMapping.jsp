<%--
  **************************************************-
  Ingrid Server OpenSearch
  ==================================================
  Copyright (C) 2014 - 2018 wemove digital solutions GmbH
  ==================================================
  Licensed under the EUPL, Version 1.1 or – as soon they will be
  approved by the European Commission - subsequent versions of the
  EUPL (the "Licence");
  
  You may not use this work except in compliance with the Licence.
  You may obtain a copy of the Licence at:
  
  http://ec.europa.eu/idabc/eupl5
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the Licence is distributed on an "AS IS" basis,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the Licence for the specific language governing permissions and
  limitations under the Licence.
  **************************************************#
  --%>
<%@ include file="timeoutcheck.jsp"%>
<%
// delete Session attributes
request.getSession().removeAttribute("tables");
request.getSession().removeAttribute("construct");
request.getSession().removeAttribute("fields");
request.getSession().removeAttribute("connection");
request.getSession().removeAttribute("controller");

response.sendRedirect(response.encodeRedirectURL("dbConnection.jsp?reset=true"));
%>
