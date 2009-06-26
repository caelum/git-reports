module Template

HEAD = <<-HEADER
<html>
  <head>
    <title>Statistics for %TYPE%</title>
  </head>
  <body>
  <h2>Statistics for %TYPE%</h2>
  <p>From %FROM% to %TO%</p>
HEADER

TAIL = <<-TAIL
  </body>
</html>
TAIL

MAJOR_HEAD = <<-MAJOR
    <br>
    <table border=1; width="500px">
      <tr>
        <td width="350px"><strong>%MAJOR%</strong></td>
        <td width="150px"><strong>Lines</strong></td>
      </tr>
MAJOR

MAJOR_TAIL = <<-MAJOR
    </table>
MAJOR

MINOR = <<-MINOR
      <tr>
        <td>%MINOR%</td>
        <td>%LINES%</td>
      </tr>
MINOR

end