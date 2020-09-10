/**
 * 사용법
 * 
 * 1.
 <html>
  <a href="javascript:;" id="viewLcnsCd" data-code="${list.bizcd } "> ${list.bizcd }</a>
</html>  
 * 2. 
 <script>
   $( "#viewLcnsCd" ).click( function(e) {
    e.preventDefault();

    var bizcdData = $( this ).data( 'code' );
    var data = {
      "bizcd" : bizcdData,
      "${_csrf.parameterName}" : "${_csrf.token}"
    };
    $.redirectPost( 'viewForm.ivs', data ); // send 
  } );
 </script>
 */

$.extend( {
  redirectPost : function(location, args) {
    var form = $( '<form></form>' );
    form.attr( "method", "post" );
    form.attr( "action", location );

    $.each( args, function(key, value) {
      var field = $( '<input></input>' );
      field.attr( "type", "hidden" );
      field.attr( "name", key );
      field.attr( "value", value );
      form.append( field );
    } );

    $( form ).appendTo( 'body' ).submit();
  }
} );