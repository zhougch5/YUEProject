Template.profile.helpers ({
	images: ->
		cover = this.cover
		console.log cover
		return UploadForActivity.findbyid cover

})

