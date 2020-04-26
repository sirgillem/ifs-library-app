// Initialise form objects
$(document).ready(function() {
	// Initialise select2 form inputs
	$('.select-searchable').select2();

	// Add event delegation to allow nested forms to get updated
	document.addEventListener('click', e => {
		$('.select-searchable').each(function() {
			if ($(this).hasClass('select2-hidden-accessible')) {
				// Select2 has been initialised
			} else {
				$(this).select2();
			}
		});
	});
});
