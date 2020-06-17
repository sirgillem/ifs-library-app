// Sorting logic taken from https://stackoverflow.com/questions/14267781/sorting-html-table-with-javascript
function makeTableSortable(){
	const getCellValue = (tr, idx) => tr.children[idx].innerText || tr.children[idx].textContent;
	
	const comparer = (idx, asc) => (a, b) => ((v1, v2) => 
	    v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2) ? v1 - v2 : v1.toString().localeCompare(v2)
	    )(getCellValue(asc ? a : b, idx), getCellValue(asc ? b : a, idx));
	
	// do the work...
	document.querySelectorAll('th.sortable').forEach(th => th.addEventListener('click', (() => {
	    const table = th.closest('table').getElementsByTagName('tbody')[0];
		console.log(table.querySelectorAll('tr').length)
	    Array.from(table.querySelectorAll('tr'))
	        .sort(comparer(Array.from(th.parentNode.children).indexOf(th), this.asc = !this.asc))
	        .forEach(tr => table.appendChild(tr) );
	})));
};

window.addEventListener('turbolinks:load', makeTableSortable);
