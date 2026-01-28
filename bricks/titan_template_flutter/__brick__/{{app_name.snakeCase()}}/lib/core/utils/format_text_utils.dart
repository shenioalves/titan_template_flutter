class FormatTextUtils {
  static final List<String> months = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];

  static String formatCPF(String value) {
    String cpf = value.replaceAll(".", "").replaceAll("-", "");
    String cpfFormatado = "";

    for (int i = 0; i < cpf.length; i++) {
      if (i == 3 || i == 6) {
        cpfFormatado += ".";
      }
      if (i == 9) {
        cpfFormatado += "-";
      }

      cpfFormatado += cpf[i];
    }

    return cpfFormatado;
  }

  static String formatCPJ(String value) {
    String cnpj = value.replaceAll(".", "").replaceAll("-", "");
    String cnpjFormatado = "";

    for (int i = 0; i < cnpj.length; i++) {
      if (i == 2 || i == 5) {
        cnpjFormatado += ".";
      }
      if (i == 8) {
        cnpjFormatado += "/";
      }
      if (i == 12) {
        cnpjFormatado += "-";
      }

      cnpjFormatado += cnpj[i];
    }

    return cnpjFormatado;
  }

  static String formatPhone(String value) {
    String phone = value.replaceAll(RegExp(r'[^0-9]'), '');

    String phoneFormatado = "";

    for (int i = 0; i < phone.length; i++) {
      if (i == 0) {
        phoneFormatado += "(";
      }

      if (i == 2) {
        phoneFormatado += ") ";
      }

      if (phone.length > 8) {
        if (i == 7) {
          phoneFormatado += "-";
        }
      } else {
        if (i == 6) {
          phoneFormatado += "-";
        }
      }

      phoneFormatado += phone[i];
    }

    return phoneFormatado;
  }

  static String formatDateMonthYearInput(String input) {
    input = input.replaceAll(RegExp(r'[^0-9]'), '');

    if (input.length >= 2) {
      input = input.substring(0, 2) +
          (input.length > 2 ? '/' : '') +
          input.substring(2);
    }

    return input;
  }

  static String formatDateInput(String value) {
    String date = value.replaceAll(RegExp(r'[^0-9]'), '');
    String dateFormatado = "";

    for (int i = 0; i < date.length; i++) {
      if (i == 2 || i == 4) {
        dateFormatado += "/";
      }

      dateFormatado += date[i];
    }

    return dateFormatado;
  }

  static String formatText(String nameFull) {
    List<String> partes = nameFull.toLowerCase().split(' ');
    List<String> nomeFormatado = [];

    for (String parte in partes) {
      if (parte.isNotEmpty && parte.length > 2) {
        nomeFormatado.add(
          (parte[0] != '('
                  ? parte[0].toUpperCase()
                  : '(${parte[1].toUpperCase()}') +
              (parte[0] != '(' ? parte.substring(1) : parte.substring(2)),
        );
      } else if (parte.isNotEmpty && (parte.length == 1 || parte.length == 2)) {
        nomeFormatado.add(parte.toLowerCase());
      }
    }

    return nomeFormatado.join(' ');
  }

  static String getFristName(String fullName) {
    var listName = fullName.split(" ");
    var firstNameUppper = listName.first;

    var primeiraLetra = firstNameUppper.substring(0, 1);
    var restoDaString = firstNameUppper.substring(1);
    var firstName = primeiraLetra.toUpperCase() + restoDaString.toLowerCase();

    return firstName;
  }

  static String formatCns(String fullCns) {
    String cnsFormatado = "";

    for (int i = 0; i < fullCns.length; i++) {
      if (i == 4 || i == 8 || i == 12) {
        cnsFormatado += " ";
      }

      cnsFormatado += fullCns[i];
    }

    return cnsFormatado;
  }

  static String formatDate(String dateFull,
      {int incrementDay = 0,
      int incrementMonth = 0,
      int incrementYear = 0,
      bool monthIsNumber = true}) {
    if (dateFull == '') return dateFull;

    late DateTime date;

    List<String> dateList = dateFull.replaceAll('-', '/').split("/");

    if (dateList[2].length == 4) {
      date = DateTime.parse("${dateList[2]}-${dateList[1]}-${dateList[0]}");
    } else {
      date = DateTime.parse("${dateList[0]}-${dateList[1]}-${dateList[2]}");
    }

    var newDate = DateTime(
      date.year + incrementYear,
      date.month + incrementMonth,
      date.day + incrementDay,
    );

    var day = newDate.day.toString().padLeft(2, '0');
    var month = newDate.month.toString().padLeft(2, '0');

    if (monthIsNumber) {
      return '$day/$month/${newDate.year}';
    } else {
      return '$day de ${months[newDate.month - 1]} de ${newDate.year}';
    }
  }

  static String formatCep(String value) {
    String cep = value.replaceAll(RegExp(r'[^0-9]'), '');
    String cepFormatado = "";

    if (cep == '') return cep;

    for (int i = 0; i < cep.length; i++) {
      if (i == 2) {
        cepFormatado += ".";
      }
      if (i == 5) {
        cepFormatado += "-";
      }
      cepFormatado += cep[i];
    }

    return cepFormatado;
  }

  static String maskEmail(String email) {
    if (email.isEmpty || !email.contains('@')) return 'email não informado';
    var parts = email.split('@');
    return '${parts[0].substring(0, 3)}*****@${parts[1].substring(0, 2)}***.com';
  }

  static String removeFormatting(String input) {
    return input.replaceAll(RegExp(r'[^\d]'), '');
  }

  static String formatarData(String? data) {
    if (data == null) return '';

    final meses = {
      1: 'Janeiro',
      2: 'Fevereiro',
      3: 'Março',
      4: 'Abril',
      5: 'Maio',
      6: 'Junho',
      7: 'Julho',
      8: 'Agosto',
      9: 'Setembro',
      10: 'Outubro',
      11: 'Novembro',
      12: 'Dezembro'
    };

    final date = DateTime.parse(data);
    return "${date.day} de ${meses[date.month]}";
  }

  static String formatMonths(int months) {
    if (months < 12) {
      return '$months meses';
    } else {
      final years = months ~/ 12;
      final remainingMonths = months % 12;
      if (remainingMonths == 0) {
        return '$years ${years == 1 ? 'ano' : 'anos'}';
      } else {
        return '$years ${years == 1 ? 'ano' : 'anos'} $remainingMonths meses';
      }
    }
  }

  static String convertToHHMM(double decimalHours) {
    int hours = decimalHours.floor();

    int minutes = ((decimalHours - hours) * 60).round();

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');

    return "$formattedHours:$formattedMinutes";
  }

  static String decimalHoursToString(num decimalHours) {
    int hours = decimalHours.floor();
    double minutesDecimal = (decimalHours - hours) * 60;
    int minutes = minutesDecimal.floor();
    int seconds = ((minutesDecimal - minutes) * 60).round();

    // Tratando singular e plural corretamente
    String hoursText = hours == 1 ? "1 hora" : "$hours horas";
    String minutesText = minutes == 1 ? "1 minuto" : "$minutes minutos";
    String secondsText = seconds == 1 ? "1 segundo" : "$seconds segundos";

    if (hours > 0) {
      // Tem horas
      if (seconds > 0) {
        return "$hoursText, $minutesText e $secondsText";
      } else if (minutes > 0) {
        return "$hoursText e $minutesText";
      } else {
        return hoursText;
      }
    } else {
      // Não tem horas
      if (seconds > 0) {
        return "$minutesText e $secondsText";
      } else {
        return minutesText;
      }
    }
  }

  static num normalizeDecimalInput(String input) {
    String normalized = input.trim();

    if (normalized.contains(',')) {
      normalized = normalized.replaceAll(',', '.');
    }

    return num.tryParse(normalized) ?? 0;
  }
}
