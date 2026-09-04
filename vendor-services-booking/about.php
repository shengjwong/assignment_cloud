<?php
require 'config.php';
require 'auth.php';

$pageTitle = 'About';
require 'partials/header.php';
?>
<div class="page-header">
<h1>About This Platform</h1>
<p>What Vendor Services is, and how it works.</p>
</div>

<section>
<h2>Our Mission</h2>
<p>Vendor Services provides users with one seamless platform to book time slots with local service vendors — including printing, laundry, tailoring, tech repair, and more — eliminating long waiting times and hassle.</p>
</section>

<section>
<h2>How It Works</h2>
<div class="card-grid">
<div class="card">
<div class="card-icon">&#127978;</div>
<h3>1. Browse Vendors</h3>
<p>Discover trusted service vendors, categorized by service type and location.</p>
</div>
<div class="card">
<div class="card-icon">&#128197;</div>
<h3>2. Book a Slot</h3>
<p>Pick a date and time slot that perfectly fits your schedule.</p>
</div>
<div class="card">
<div class="card-icon">&#9989;</div>
<h3>3. Manage Bookings</h3>
<p>Edit or cancel your appointments anytime directly from your dashboard.</p>
</div>
</div>
</section>

<section>
<h2>Who Runs This</h2>
<p>This platform is designed and managed to connect clients with quality service providers efficiently.</p>
</section>
<?php require 'partials/footer.php'; ?>