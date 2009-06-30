module Template

HEAD = <<-HEADER
<html>
  <head>
    <title>%TITLE%</title>
  </head>
  <body>
  <h2>%TITLE%</h2>
  <p>From %FROM% to %TO%</p>
HEADER

TAIL = <<-TAIL
  </body>
</html>
TAIL

MAJOR_HEAD = <<-MAJOR
    <br>
    <table border=1; width="600px">
      <tr>
        <td width="450px"><strong>%MAJOR%</strong></td>
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

COMMIT = <<-COMMIT
    <br>
    <table border=1; width="600px">
      <tr><td><strong>%REPOSITORY%</strong></td></tr>
      <tr><td>%MESSAGE%</td></tr>
      <tr><td><strong>by</strong> %COMMITER% <strong>at</strong> %TIMEDATE%</td></tr>
    </table>
COMMIT
end