import 'package:intl/intl.dart';

String formatDate(String isoDate) {
  // Converte a string de data para o tipo DateTime
  DateTime parsedDate = DateTime.parse(isoDate);

  // Formata a data no estilo desejado: dia/mês/ano e hora:minuto
  String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(parsedDate);

  return formattedDate;
}
