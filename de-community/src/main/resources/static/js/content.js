$(document).ready(function () {

    //濡쒓렇�� �낅졄�� 
    $('input').focus(function (event) {
        $(this).closest('.join-field').addClass('float').addClass('focus');
    })

    $('input').blur(function () {
        $(this).closest('.join-field').removeClass('focus');
        if (!$(this).val()) {
            $(this).closest('.join-field').removeClass('float');
        }
    });

    
    //�щ젰
    $("#date1").datepicker({
        showOn: "button",
        buttonImage: "../../img/datepicker-icon.png",
        buttonImageOnly: false,
        buttonText: "Select date"
    });

    $("#date2").datepicker({
        showOn: "button",
        buttonImage: "../../img/datepicker-icon.png",
        buttonImageOnly: false,
        buttonText: "Select date"
    });
     $("#date3").datepicker({
        showOn: "button",
        buttonImage: "../../img/datepicker-icon.png",
        buttonImageOnly: false,
        buttonText: "Select date"
    });


});