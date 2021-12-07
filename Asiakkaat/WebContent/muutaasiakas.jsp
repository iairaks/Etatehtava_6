<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<title>Muuta asiakas</title>
<link rel="stylesheet" href="css/main.css" type="text/css" /> 
</head>
<body>
<form id="tiedot">
	<table>
		<thead>
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td>
				<td><input type="submit" id="tallenna" value="Päivitä"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name= "asiakas_id" id="asiakas_id">
</form>
<span id="ilmoitus"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	
	var asiakas_id = requestURLParam("asiakas_id");
	$.ajax({url:"asiakkaat/haeyksi/"+asiakas_id, type:"GET", dataType:"json", success:function(result) {
		$("#asiakas_id").val(asiakas_id);
		$("#etunimi").val(result.etunimi);
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);
	}});
$("#tiedot").validate({
	rules: {
		etunimi: {
			required: true,
			minlength: 2
		},
		sukunimi: {
			required: true,
			minlength: 2
		},
		puhelin: {
			required: true,
			minlength: 8
		},
		sposti: {
			required: true,
			minlength: 8
		}
	},
	messages: {
		etunimi: {
			required: "Tyhjä",
			minlength: "Jäikö jotain uupumaan?"
		},
		
		sukunimi: {
			required: "Laita ees jotain",
			minlength: "Olekko aivan varma?"
		},
		puhelin: {
			required: "Esimerkiksi 0,1,2,3...",
			minlength: "Tarkistappa vielä"
		},
		sposti: {
			required: "Tyhjä",
			minlength: "Lähellä ollaan..."
		}
		
	},
	
	submitHandler: function(form) {
		paivitaTiedot();
	}
});
});
function paivitaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat/", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmoitus").html("Asiakkaan päivittäminen epäonnistui.");
      }else if(result.response==1){			
      	$("#ilmoitus").html("Asiakkaan päivittäminen onnistui.");
      	$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
	  }
  }});	
}
</script>
</body>
</html>