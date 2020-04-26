class unhideSiblings {
	constructor() {
		this.links = document.querySelectorAll('.unhide-siblings');
		this.iterateLinks();
	}

	iterateLinks() {
		if (this.links.length === 0) return;
		this.links.forEach((link)=>{
			link.addEventListener('click', this.handleClick);
		});
	}

	handleClick(e) {
		let link = e.currentTarget;
		if (!link || !e) return;
		e.preventDefault();

		// Remove 'hidden' class from all sibling elements
		var sibling = link.parentNode.firstChild;
		while (sibling) {
			if (sibling.nodeType === 1) {
				sibling.classList.remove("hidden");
			}
			sibling = sibling.nextSibling;
		}
	}
}

// Add handler after trubolinks loaded
window.addEventListener('turbolinks:load', () => new unhideSiblings() );
