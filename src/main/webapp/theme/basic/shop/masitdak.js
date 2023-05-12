/**
 * object를 생생
 * 
 * @param c
 * @returns {Array}
 */
function initObj(c) {
	var rse = new Array();
	for (var i = 0; i < 10; i++) {
		if (document.getElementById(c + (i + 1)) == null) {
			break;
		} else {
			rse[i] = document.getElementById(c + (i + 1));
		}
	}
	return rse;
}

/**
 * 하위 메뉴의 디스플레이 관리
 * 
 * @param obj
 * @param ck
 */
function layerSubMenu(obj, ck) {
	var obj = obj;
	var n = ck;
	(typeof (n) == 'undefined') ? n = 0 : n = n;

	for (var i = 0; i < obj.length; i++) {
		if (n == i)
			obj[i].style.display = "block";
		else
			obj[i].style.display = "none";
	}
}

/**
 * 레이어 하위 메뉴 그룹의 디스플레이 관리
 * 
 * @param target
 * @param chk
 */
function layerMenu(target, ck) {
	var n = ck;
	var target = document.getElementById(target);
	var dot = document.getElementById('dot');
	var wrap = document.getElementById('layerWrap');

	var m_array = initObj('layer_con_main'); // 객체 생성

	(n == 'undefined') ? n = 0 : n = n;

	layerSubMenu(m_array, n);

	target.style.display = "block";
	dot.style.display = "block";
	wrap.style.display = "block";
}

/**
 * 레이어 content 디스플레이 관리
 * 
 * @param target
 * @param chk
 */
function layerContent(target, chk) {
	var n = chk;
	var m_array = initObj('layer_con_main'); // 레이어 제목그룹 객체 생성
	var con_array = initObj('layer_con'); // 레이어 content 객체 생성

	layerSubMenu(m_array, n);

	for (var i = 0; i < con_array.length; i++) {
		if (con_array[i].id == target) {
			con_array[i].style.display = "block";
		} else {
			con_array[i].style.display = "none";
		}
	}

}

/**
 * 레이어 숨기기
 */
function layer_hid(type) {
	var dot = document.getElementById('dot');
	var m_array = initObj('layer_con_main'); // 레이어 제목그룹 객체 생성
	var con_array = initObj('layer_con'); // 레이어 content 객체 생성
	
	if(type == 'ifram') {
		document.getElementById('iframWrap').style.display = "none";
	}else {
		document.getElementById('layerWrap').style.display = "none";
	}

	for (var i = 0; i < con_array.length; i++) {
		con_array[i].style.display = "none";
	}

	for (var i = 0; i < m_array.length; i++) {
		m_array[i].style.display = "none";
	}

	dot.style.display = "none";
}

/**
 * 제품 상세정보 레이어를 호출
 * @param url
 */
function frame_submit(url) {
	var dot = document.getElementById('dot');
	var wrap = document.getElementById('iframWrap');
	var con = document.getElementById('ifram_content');
	con.contentWindow.location.replace(url);

	dot.style.display = "block";
	wrap.style.display = "block";
}
