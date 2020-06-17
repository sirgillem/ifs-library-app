// Sorting logic adapted from https://stackoverflow.com/questions/14267781/sorting-html-table-with-javascript

function stripSortIndicator(e) {
	if (e.textContent.match('[\u25b2\u25bc]$')) {
		e.textContent = e.textContent.slice(0,-2);
	};
};

function makeTableSortable(){
	const getCellValue = (tr, idx) => tr.children[idx].innerText || tr.children[idx].textContent;
	
	const comparer = (idx, asc) => (a, b) => ((v1, v2) => 
	    v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2) ? v1 - v2 : v1.toString().localeCompare(v2)
	    )(getCellValue(asc ? a : b, idx), getCellValue(asc ? b : a, idx));
	
	// do the work...
	document.querySelectorAll('th.sortable').forEach(th => {
		th.addEventListener('click', (() => {
	    		const table = th.closest('table').getElementsByTagName('tbody')[0];
	    		Array.from(table.querySelectorAll('tr'))
	        		.sort(comparer(Array.from(th.parentNode.children).indexOf(th), this.asc = !this.asc))
	        		.forEach(tr => table.appendChild(tr) );
			// We only sort by one column at a time, so show it that way
			th.parentNode.querySelectorAll('th').forEach(th1 => stripSortIndicator(th1));
			if (this.asc) {
				th.textContent += " \u25b2";
			} else {
				th.textContent += " \u25bc";
			};
		}))
	});
};

window.addEventListener('turbolinks:load', makeTableSortable);
