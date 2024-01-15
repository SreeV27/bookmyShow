<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chosen Multi-Select Example</title>
  <!-- Chosen CSS -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css">
  <style>
    /* Add a custom class and set the width */
    .custom-chosen {
      width: 200px; /* Set your desired width */
    }
  </style>
</head>
<body>

<div class="container mt-5">
  <h3>Chosen Multi-Select Example</h3>
  <select data-placeholder="Choose options..." multiple class="chosen-select custom-chosen">
    <option value="1">Option 1</option>
    <option value="2">Option 2</option>
    <option value="3">Option 3</option>
  </select>
</div>

<!-- jQuery (Chosen requires jQuery) -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!-- Chosen JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>

<script>
  // Initialize Chosen on the select element
  $(document).ready(function() {
    $('.chosen-select').chosen();
  });
</script>

</body>
</html>
