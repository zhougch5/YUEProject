Template.changeProfile.events {
	'change .avatar-input': (e)!->

		e.preventDefault!

		if typeof FileReader is undefined
			alert '抱歉，你的浏览器不支持预览功能'

		reader = new FileReader()
		file = e.target.files[0]
		reader.readAsDataURL file
		reader.onload = (e)!->
			$ '#cover' .attr 'src', reader.result

	"click .confirmForModifyProfile": (e) !->
		# $(".segment") .addClass "error"
		# $ ".password" .removeClass 'error'
		# $ ".confirmPassword" .removeClass 'error'

		$(".changeProfile").form {
			nickname: {
				identifier : 'nickname'
				rules: [
					{
						type : 'empty'
						prompt: 'Please enter your nickname'
					}
				]
			}
			tel: {
				identifier : 'tel'
				rules: [
					{
						type : 'empty'
						prompt : 'Please enter your phone number'
					}
				]
			}
			qq: {
				identifier : 'qq'
				rules: [
					{
						type : 'empty'
						prompt : 'Please enter your qq number'
					}
				]
			}
			mail: {
				identifier : 'mail'
				rules: [
					{
						type : 'empty'
						prompt : 'Please enter your mail'
					}
					{
						type : 'email'
						prompt : 'Please enter a valid email address'
					}
				]
			}
		}
		re = /^1\d{10}$/
		tel = $('.tel').find '[name=tel]' .val!
		msg = '<li>Your phone number must be 11 characters only in number</li>'
		if !re.test(tel)
			console.log 'func you'
			$('.tel') .addClass 'error'
			$('.message').find('ul') .append msg
			# return

		re1 = /\d{5}[0-9]+/
		qq = $('.qq').find '[name=qq]' .val!
		msg2 = '<li>Your qq number must be only number more than six</li>'
		if !re1.test(qq)
			$('.qq') .addClass 'error'
			$('.message').find('ul') .append msg2
			# return


	"submit form": (e) ->
		e.prevent-default!
		# $('.tel') .removeClass 'error'
		# $('.qq') .removeClass 'error'
		# $ ".password" .removeClass 'error'
		# $ ".confirmPassword" .removeClass 'error'
		$ ".passwordLengthProblem" .addClass 'hidden'
		$ ".passwordDifferentProblem" .addClass 'hidden'
		

		# passwordForSubmit = $('.password').find('[name=password]') .val!
		# confirmPassword = $('.confirmPassword').find('[name=confirmPassword]') .val!

		# if passwordForSubmit.length < 6 and passwordForSubmit.length != 0
		# 	$ ".passwordLengthProblem" .removeClass 'hidden'
		# 	# $(".changeProfile").form {}
		# 	# e.target.reset!
		# 	return
		# else if passwordForSubmit != confirmPassword and passwordForSubmit.length != 0
		# 	$ ".passwordDifferentProblem" .removeClass 'hidden'
		# 	# $(".changeProfile").form {}
		# 	# e.target.reset!
		# 	return
		# else

		avatar = $(e.target).find('[name=avatar]')[0].files
		# password = $(e.target).find('[name=password]')

		tempUser = User.current-user!	
		profile = {
			nickname: $(e.target).find '[name=nickname]' .val!
			sex: $(e.target).find '[name=sex]' .val!
			tel: $(e.target).find '[name=tel]' .val!
			qq: $(e.target).find '[name=qq]' .val!
			mail: $(e.target).find '[name=mail]' .val!
			avatarId: tempUser.profile.avatarId
		}
		

		User.change-information(profile,  (error) ->
			if not error
				if avatar.length isnt 0
					UploadAvatar.update avatar
					Router.go '/'
				else
					Router.go '/'
			)
}

Template.changeProfile.helpers {
	sex: ->
		user=User.current-user!
		return {
			male: ->
				if user.profile.sex is "male"
					return "selected"
			female: ->
				if user.profile.sex is "female"
					return "selected"
		}
}
