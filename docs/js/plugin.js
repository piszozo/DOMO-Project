/* bootstrap menu custom code */
$(document).ready(function() {
	$("#myCarousel .item:first-child").addClass("active"); // This code use in slider
	$("ol.carousel-indicators li:first-child").addClass("active");  // use in dots of slider
    $("ul.navbar-nav li").find("ul").addClass("dropdown-menu").parent("li").addClass("dropdown");
});

$( window ).scroll(function() {if ($(this).scrollTop() > 100) {$('#backtotop').fadeIn();} else {$('#backtotop').fadeOut();}});
$(document).on("click","#backtotop",function(){$('html,body').animate({scrollTop: 0}, 1500);});



var winHeight;
$(document).ready(function(){
	winHeight = $( window ).height();
	/* $('.slider .item').css('height',winHeight); */
	
	
});
$(window).resize(function(){
	resizeContent();
	winHeight = $( window ).height();
	/* $('.slider .item').css('height',winHeight); */
	
});
resizeContent();

function resizeContent()
{
	if(window.innerWidth > 768){
		$(".mobile-menu").css("display", "none");
		$(".menu").css("display", "block");
	} 
	else if(window.innerWidth < 767)
	{
		$('.nav>li>a').click(function(e){
			e.preventDefault();
			$('.navbar-collapse.collapse').removeClass("in");
		});
	};
}

$(document).ready(function() {
	/* click to jusmp section */
    var tempval;
    $('.nav>li>a').click(function(e){
        e.preventDefault();
        tempval = $(this).attr('href').split('#');
        if(tempval[1]){
            $('html, body').animate({scrollTop: ($("#"+tempval[1]).offset().top - 90) }, 1000);
        }
    });
	
$(window).on('scroll', function() {
var scrollTop = $(this).scrollTop();
$('.section').each(function() {
	var topDistance = $(this).offset().top-150;
	if ( (topDistance+100) < scrollTop ) {
		var secid = $(this).attr('id');
		$('.nav>li>a').parent().removeClass('active');
		$('.nav>li>a[href="#'+secid+'"]').parent().addClass('active');
	} else {
		
	}
});
});
});
