/**
 * Solution for Rosetta Code task ["Read a configuration file"]
 * (http://rosettacode.org/wiki/Read_a_configuration_file)
 */

#import('dart:io');


main() {
  var file = new File('fruit.cfg');
  var fullname = '';
  var favouritefruit = '';
  var needspeeling = false;
  var seedsremoved = false;
  var otherfamily = [];

  file.readAsLines().then((List<String> lines) {
    final blankOnly = const RegExp(@'^(#|;|\s*$)');
    final keyValue = const RegExp(@'\s*([^ =]+)([ =].*)?$');

    for (var line in lines) {
      if (!line.contains(blankOnly)) {
        final match = keyValue.firstMatch(line);
        final key = match[1].toLowerCase();
        final value = match[2];

        switch (key) {
          case 'fullname': fullname = value.trim(); break;
          case 'favouritefruit': favouritefruit = value.trim(); break;
          case 'needspeeling': needspeeling = true; break;
          case 'seedsremoved': seedsremoved = true; break;
          case 'otherfamily':
            otherfamily = value.split(',').map((s) => s.trim());
            break;
        }
      }
    }

    print('fullname = $fullname');
    print('favouritefruit = $favouritefruit');
    print('needspeeling = $needspeeling');
    print('seedsremoved = $seedsremoved');
    print('otherfamily = $otherfamily');
  });
}
