import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/size_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';
import '../../../../models/payment_type_model.dart';
import '../../payment_type_controller.dart';

class PaymentTypeFormModal extends StatefulWidget {
  final PaymentTypeController controller;
  final PaymentTypeModel? model;

  const PaymentTypeFormModal({
    required this.controller,
    required this.model,
    super.key,
  });

  @override
  State<PaymentTypeFormModal> createState() => _PaymentTypeFormModalState();
}

class _PaymentTypeFormModalState extends State<PaymentTypeFormModal> {
  void _closeModal() => Navigator.of(context).pop();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _acronymController = TextEditingController();

  var enabled = false;

  @override
  void initState() {
    super.initState();

    final paymentModel = widget.model;

    if (paymentModel != null) {
      _nameController.text = paymentModel.name;
      _acronymController.text = paymentModel.acronym;
      enabled = paymentModel.enabled;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _acronymController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth * (screenWidth > 1200 ? .5 : .7),
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.model == null ? 'Adicionar' : 'Editar'} forma de pagamento',
                      textAlign: TextAlign.center,
                      style: context.textStyles.textTitle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: _closeModal,
                      child: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                validator: Validatorless.required('Nome obrigatório'),
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _acronymController,
                validator: Validatorless.required('Sigla obrigatória'),
                decoration: const InputDecoration(
                  label: Text('Sigla'),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Ativo',
                    style: context.textStyles.textRegular,
                  ),
                  Switch(
                    value: enabled,
                    onChanged: (value) {
                      setState(() {
                        enabled = value;
                      });
                    },
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: OutlinedButton(
                      onPressed: _closeModal,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Cancelar',
                        style: context.textStyles.textExtraBold
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final valid =
                            _formKey.currentState?.validate() ?? false;

                        if (valid) {
                          final name = _nameController.text;
                          final acronym = _acronymController.text;

                          widget.controller.savePayment(
                            name: name,
                            acronym: acronym,
                            enabled: enabled,
                            id: widget.model?.id,
                          );
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
