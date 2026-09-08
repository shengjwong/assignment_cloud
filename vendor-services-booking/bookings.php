<?php
require 'config.php';
require 'auth.php';

require_login();

$userId = (int) current_user_id();

$stmt = $conn->prepare('
    SELECT
        b.id,
        v.vendor_name,
        b.booking_date,
        b.time_slot,
        b.purpose,
        b.quantity,
        b.estimated_total,
        v.unit_label
    FROM bookings b
    JOIN vendors v ON v.id = b.vendor_id
    WHERE b.user_id = ?
    ORDER BY b.booking_date DESC, b.time_slot ASC
');
$stmt->bind_param('i', $userId);
$stmt->execute();
$bookings = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt->close();

$pageTitle = 'My Bookings';
$pageDescription = 'View your GUGUGAGA service bookings.';
require 'partials/header.php';
?>

<h1>My Bookings</h1>

<?php if (empty($bookings)): ?>

<div class="empty-state">
    <div class="empty-state-icon">&#128197;</div>
    <p>You have no bookings yet.</p>
    <p>
        <a href="schedule.php" class="btn">Make a Booking</a>
    </p>
</div>

<?php else: ?>

<table>
    <tr>
        <th>Vendor</th>
        <th>Date</th>
        <th>Time Slot</th>
        <th>Purpose</th>
        <th>Qty</th>
        <th>Est. Total (RM)</th>
    </tr>

    <?php foreach ($bookings as $b): ?>
    <tr>
        <td><?= htmlspecialchars($b['vendor_name']) ?></td>

        <td><?= htmlspecialchars($b['booking_date']) ?></td>

        <td><?= htmlspecialchars($b['time_slot']) ?></td>

        <td><?= htmlspecialchars($b['purpose']) ?></td>

        <td>
            <?= (int) $b['quantity'] ?>
            <?= htmlspecialchars($b['unit_label']) ?>(s)
        </td>

        <td>
            RM <?= number_format((float) $b['estimated_total'], 2) ?>
        </td>
    </tr>
    <?php endforeach; ?>

</table>

<?php endif; ?>

<?php require 'partials/footer.php'; ?>