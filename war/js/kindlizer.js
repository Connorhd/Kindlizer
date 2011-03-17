	var curPage = 0;
	var numPages = 0;
	var forceRefresh = true;
	var page = 0;
	var setPages = function (pages) {
		numPages = pages;
		$('#scroll').height(pages*706);
	};
	var clearScreen = function () {
		$('#screen .content').remove();
		page = 0;
		curPage = 0;
		$('#screen').append('<div class="content" id="page'+page+'"></div>');
		setPages(1);
	}				
	
	var kindlize = function (kindlizable) {
		var supportedElements = ['A','IMG','H1','H2','H3','H4','H5','H6','SPAN','TABLE','UL','OL'];
		var elements = kindlizable.children();
		var i;
		for (i = 0; i < elements.length; i++) {
			if (elements[i].tagName == 'P') {
				$('#page'+page).append($(elements[i]));
				if ($('#page'+page).height() > 673) {
					kindlizable.prepend($(elements[i]));
				
					var text = $(elements[i]).text().split(" ");
					var p = $('<p></p>');
					$('#page'+page).append(p);
					var j;
					// TODO: This could be a binary search
					for (j = 0; j < text.length; j++) {
						$(p).text($(p).text()+' '+text[j]);
						if ($('#page'+page).height() > 673) {
							$(p).text($(p).text().substring(0, $(p).text().length-(text[j].length+1)));
							j--;
							// New page
							page++;
							$('#screen').append('<div class="content" id="page'+page+'"></div>');
							p = $('<p></p>');
	                        $('#page'+page).append(p);
						}
					}
				}
			} else if (supportedElements.indexOf(elements[i].tagName) !== -1) {
				$('#page'+page).append($(elements[i]));
	
				if ($('#page'+page).children().length > 1 && $('#page'+page).height() > 673) {
					i--;
					// New page
					page++;
					$('#screen').append('<div class="content" id="page'+page+'"></div>');
				}
			}
		}
		setPages(page+1);
		forceRefresh = true;
		kindlizable.html('');
	};
$(function () {

	setInterval(function() {
		var newPage = curPage;

		if ($('#outer').scrollTop() > curPage*706) {
			if (($('#outer').scrollTop() - curPage*706) == 666)
				newPage++;
			else
				$('#outer').scrollTop(curPage*706);
		} else if ($('#outer').scrollTop() < curPage*706) {
			if (($('#outer').scrollTop() - curPage*706) == -666)
				newPage--;
			else
				$('#outer').scrollTop(curPage*706);
		}
		if (newPage !== curPage || forceRefresh) {
			forceRefresh = false;
			$('#page'+curPage).css('display', 'none');
			$('#page'+newPage).css('display', 'block');
			curPage = newPage;
			$('#outer').scrollTop(curPage*706);
			$('#footer').text('Page '+(curPage+1)+' of '+numPages);
		}
	}, 100);

	clearScreen();

	kindlize($('#kindlize'));
});