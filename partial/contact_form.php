<div class="contact_form">

<form action="/contact/do_contact/" method="post" accept-charset="utf-8">
	<table>
		<tr>
			<td class="label">
				Name:
			</td>
			<td class="data">
				<input type="text" name="name" value="" id="name" maxlength="32" />
			</td>
		</tr>
		<tr>
			<td class="label">
				Company <span class="note">(optional)</span>:
			</td>
			<td class="data">
				<input type="text" name="company" value="" id="company" maxlength="32" />
			</td>
		</tr>
		<tr>
			<td class="label">
				Phone Number <span class="note">(optional)</span>:
			</td>
			<td class="data">
				<input type="text" name="phone" value="" id="phone" maxlength="16" />
			</td>
		</tr>
				<tr>
			<td class="label">
				Security Word [<a href="http://en.wikipedia.org/wiki/CAPTCHA" title="What is this???">?</a>]:
			</td>
			<td class="data">
				<div class="captcha">
					<img src="art/captcha.php" width="200" height="61" alt="Visual CAPTCHA" />
					<span>[Please input the code from the image above.]</span>
					<input type="text" name="captcha" maxlength="5" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="label">
				Message:
			</td>
			<td class="data">
				<textarea name="msg" rows="8" cols="40" maxlength="1024"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="submit_cell">
				<input type="reset" name="reset" value="Reset" id="reset">
				<input type="submit" value="Continue &rarr;">
			</td>
		</tr>
	</table>
</form>
	
</div>