<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<title>PAYMENT</title>
</head>
<body>

	<div class="container text-center">

		<h3 class="my-3">DO PAYMENT</h3>
		<input id="payment_field" type="text" class="form-control my-2"
			placeholder="enter amount here" />

		<div class="container text-center mt-3">
			<button onclick="paymentStart()" class="btn btn-success btn-block">PAY</button>
		</div>

	</div>

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->

	<script src="https://code.jquery.com/jquery-3.7.0.min.js"
		integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
		crossorigin="anonymous"></script>
	<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script src="/js/script.js"></script>

	<script>
	
	// first reqest to server to create order

	const paymentStart = () => {
		console.log("Payment Started");
		let amount = $("#payment_field").val();
		console.log(amount);
		if (amount == "" || amount == null) {
			alert("Amount is required!!");
			return;
		}

		// code
		// we will use ajax to send request to server to create order

		$.ajax(
			{
				url: "/create_order",
				data: JSON.stringify({ amount: amount, info: "order_request" }),
				contentType: "application/json",
				type: "POST",
				dataType: "json",
				success: function(response) {
					// invode razorpay
					console.log(response);
					if (response.status == "created") {
						// open payment form
						let options = {
							key: "rzp_test_4Q9Z4gFWd7z4y1",
							amount: response.amt,
							"currency": "INR",
							"name": "Ramkripal_Rahul",
							"description": "Test ",
							"image": "https://example.com/your_logo",
							"order_id": response.id,
							handler: function(response) {
								console.log(response.razorpay_payment_id)
								console.log(response.razorpay_order_id)
								console.log(response.razorpay_signature)
								console.log("payment done")
								alert("payment done")
							},
							"prefill": {
								"name": "RamkripalRahul",
								"email": "dubeyrahul7898@gmail.com",
								"contact": "7898****54"
							},
							"notes": {
								"address": "test"

							},
							"theme": {
								"color": "#3399cc"
							}
						};
						var rzp1 = new Razorpay(options);
						rzp1.on('payment.failed', function(response) {
							alert(response.error.code);
							alert(response.error.description);
							alert(response.error.source);
							alert(response.error.step);
							alert(response.error.reason);
							alert(response.error.metadata.order_id);
							alert(response.error.metadata.payment_id);
						});

						rzp1.open();

					}
				},
				error: function(error) {
					console.log(error);
					alert("Something went wrong!!");
				},
			});
	};

	</script>
</body>
</html>