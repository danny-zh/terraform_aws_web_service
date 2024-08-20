<?php
// Function to fetch metadata from the IMDS endpoint
function fetch_metadata($path) {
    $url = "http://169.254.169.254/latest/meta-data/" . $path;
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $result = curl_exec($ch);
    curl_close($ch);

    return $result ? htmlspecialchars($result) : 'Error fetching metadata';
}

// Metadata paths to fetch
$paths = [
    'instance-id',
    'ami-id',
    'instance-type',
    'local-ipv4',
    'public-ipv4',
    'placement/availability-zone',
    'security-groups'
];

$metadata = [];
foreach ($paths as $path) {
    $metadata[$path] = fetch_metadata($path);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EC2 Instance Metadata</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f4f4f4;
        }
        h1 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <h1>EC2 Instance Metadata</h1>
    <table>
        <thead>
            <tr>
                <th>Key</th>
                <th>Value</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($metadata as $key => $value): ?>
                <tr>
                    <td><?php echo htmlspecialchars($key); ?></td>
                    <td><?php echo $value; ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>
