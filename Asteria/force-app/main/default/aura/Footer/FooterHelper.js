({
	getCopyright: function(component) {
		let d = new Date();
        let y = String(d.getFullYear());
        if (y == "2021") {
            return y;
        } else {
            return "2021-" + y;
        }
	}
})