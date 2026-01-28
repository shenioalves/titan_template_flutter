mixin MixinsUtils {
  String? isEmpty(String? value, [String? message]) {
    if (!value!.isNotEmpty) {
      return message ?? 'Por favor, insira um valor válido';
    }
    return null;
  }

  String? matchPassword(String? valueOne, String? valueTwo, [String? message]) {
    if (valueOne != null && valueTwo != null) {
      if (valueOne != valueTwo || valueOne.isEmpty || valueTwo.isEmpty) {
        return message ?? 'As senhas não coincidem';
      }
    }

    return null;
  }

  String? moreThanFive(String? value, [String? message]) {
    if ((value?.length ?? 0) < 6) {
      return message ?? 'O código tem no mínimo 6 caracteres';
    }
    return null;
  }

  String? moreThanSeven(String? value, [String? message]) {
    if ((value?.length ?? 0) < 8) {
      return message ?? 'A senha deve ter no mínimo 8 caracteres';
    }
    return null;
  }

  String? validatePercentage(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return message ?? 'Por favor, insira um valor';
    }
    final percentage = double.tryParse(value);
    if (percentage == null || percentage < 0 || percentage > 100) {
      return message ?? 'Por favor, insira um valor entre 0 e 100';
    }
    return null;
  }

  String? hasNumber(String value, [String? message]) {
    if (!RegExp(r'\d').hasMatch(value)) {
      return message ?? 'A senha deve ter no mínimo 1 número';
    }
    return null;
  }

  String? upperLetter(String value, [String? message]) {
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return message ?? 'A senha deve ter no mínimo 1 letra maiúscula';
    }
    return null;
  }

  String? lowerLetter(String value, [String? message]) {
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return message ?? 'A senha deve ter no mínimo 1 letra minúscula';
    }
    return null;
  }

  String? validateEmail(String? value, [String? message]) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegExp.hasMatch(value!.trim())) {
      return message ?? 'Por favor, insira um e-mail válido';
    }
    return null;
  }

  String? validateTelephone(String? value, [String? message]) {
    final String phone = (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');

    if (!RegExp(r'^\d{11}$').hasMatch(phone)) {
      return message ?? 'Por favor, insira um telefone válido';
    }
    return null;
  }

  String? combine(List<String? Function()> validatores) {
    for (final func in validatores) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }

  String? validateCPF(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return message ?? 'Por favor, insira um CPF válido';
    } else {
      value = value.replaceAll('.', '');
      value = value.replaceAll('-', '');
    }

    if (value.length != 11) {
      return 'O CPF deve ter 11 dígitos';
    }

    return null;
  }

  String? validateDate(String? value, [String? message]) {
    final RegExp regExp = RegExp(
      r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$',
    );

    if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
      return message ?? 'Por favor, insira uma data válida';
    }

    if (value.replaceAll('/', '').length != 8) {
      return message ?? 'A data deve ter 8 dígitos';
    }

    return null;
  }

  String? validateMonth(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return message ?? 'Por favor, insira um mês válido';
    }

    final month = int.tryParse(value);

    if (month == null || month < 1 || month > 12) {
      return message ?? 'O mês deve estar entre 1 e 12';
    }

    return null;
  }

  String? validateYear(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final year = int.tryParse(value);

    if (year == null || year < 1900 || year > DateTime.now().year) {
      return message ?? 'Insira um ano válido';
    }

    return null;
  }

  String? validateDateNotFuture(String? value, [String? message]) {
    final RegExp regExp = RegExp(
      r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$',
    );

    if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
      return message ?? 'Por favor, insira uma data válida';
    }

    if (value.replaceAll('/', '').length != 8) {
      return message ?? 'A data deve ter 8 dígitos';
    }

    try {
      final List<String> parts = value.split(RegExp(r'\/|-|\.'));
      final int day = int.parse(parts[0]);
      final int month = int.parse(parts[1]);
      final int year = int.parse(parts[2]);

      final DateTime inputDate = DateTime(year, month, day);
      DateTime today = DateTime.now();

      today = DateTime(today.year, today.month, today.day);

      if (inputDate.isAfter(today)) {
        return message ?? 'A data informada é posterior à data atual';
      }
    } catch (e) {
      return message ?? 'Erro ao processar a data';
    }

    return null;
  }

  String? validateMonthYearNotFuture(String? value,
      [String? message, String? yearValue]) {
    if (value == null || value.isEmpty) {
      return message ?? 'Por favor, insira um mês válido';
    }

    final month = int.tryParse(value);
    if (month == null || month < 1 || month > 12) {
      return message ?? 'O mês deve estar entre 1 e 12';
    }

    if (yearValue == null || yearValue.isEmpty) {
      return null;
    }

    final year = int.tryParse(yearValue);
    if (year == null) {
      return null;
    }

    final today = DateTime.now();
    if (year > today.year || (year == today.year && month > today.month)) {
      return message ?? 'O mês informado é posterior à data atual';
    }

    return null;
  }

  String? validateYearNotFuture(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final year = int.tryParse(value);

    if (year == null || year < 1900) {
      return message ?? 'Insira um ano válido';
    }

    final currentYear = DateTime.now().year;

    if (year > currentYear) {
      return message ?? 'O ano informado é posterior ao ano atual';
    }

    return null;
  }
}
