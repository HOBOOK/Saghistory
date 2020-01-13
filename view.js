$('.viewframe').click(function() {	
	var filter = "win16|win32|win64|mac|macintel"; 
	var $id = $(this).attr('id');
	if ( navigator.platform ) 
	{ 
		if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 )
		{ 
			$(location).attr('href', 'view.jsp?idx='+$id);
		} 
		else 
		{
			$.smartPop.open({title: '스마트팝', log: false, url: 'view.jsp?idx='+$id });
		}
	}
    
});

$('.uploadframe').click(function() {
    var filter = "win16|win32|win64|mac|macintel"; 
	var $id = $(this).attr('id');
	if ( navigator.platform ) 
	{ 
		if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 )
		{ 
			$(location).attr('href', 'write.jsp');
		} 
		else 
		{
			 $.smartPop.open({title: '스마트팝', log: false, url: 'write.jsp' });
		}
	}
});