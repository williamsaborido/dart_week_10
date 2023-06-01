import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/env/env.dart';
import '../../../core/ui/helpers/loader.dart';
import '../../../core/ui/helpers/messages.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/helpers/upload_html_helper.dart';
import '../../../core/ui/styles/text_styles.dart';
import 'product_detail_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final int? productId;

  const ProductDetailPage({required this.productId, super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with Loader, Messages {
  final controller = Modular.get<ProductDetailController>();
  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final precoController = TextEditingController();
  final descricaoController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    precoController.dispose();
    descricaoController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      reaction((_) => controller.status, (status) {
        switch (status) {
          case ProductDetailStateStatus.initial:
            break;
          case ProductDetailStateStatus.loading:
            showLoader();
            break;
          case ProductDetailStateStatus.loaded:
            hideLoader();
            break;
          case ProductDetailStateStatus.error:
            hideLoader();
            showError(controller.erroMessage ?? 'Erro ao salvar produto');
            break;
          case ProductDetailStateStatus.errorLoadProduct:
            hideLoader();
            showError(controller.erroMessage ?? 'Erro ao abrir produto');
            break;
          case ProductDetailStateStatus.deleted:
            hideLoader();
            break;
          case ProductDetailStateStatus.uploaded:
            hideLoader();
            break;
          case ProductDetailStateStatus.saved:
            hideLoader();
            Navigator.pop(context);
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthButtonAction = context.percentWidth(.4);

    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(40),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.productId == null ? 'Adicionar' : 'Alterar'} produto',
                      textAlign: TextAlign.center,
                      style: context.textStyles.textTitle.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Observer(
                        builder: (_) {
                          if (controller.imagePath != null) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.network(
                                '${Env.instance.get('backend_base_url')}${controller.imagePath}',
                                width: 200,
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      Observer(
                        builder: (_) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(.9),
                              ),
                              onPressed: () {
                                UploadHtmlHelper()
                                    .startUpload(controller.uploadImageProduct);
                              },
                              child: Text(
                                '${controller.imagePath == null ? 'Adicionar' : 'Alterar'} foto',
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nomeController,
                          validator: Validatorless.required('Nome obrigatório'),
                          decoration: const InputDecoration(
                            label: Text('Nome'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: precoController,
                          validator:
                              Validatorless.required('Preço obrigatório'),
                          decoration: const InputDecoration(
                            label: Text('Preço'),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CentavosInputFormatter(moeda: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descricaoController,
                validator: Validatorless.required('Descrição obrigatório'),
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: null,
                decoration: const InputDecoration(
                  label: Text('Descrição'),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: widthButtonAction,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: widthButtonAction / 2,
                        height: 60,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Deletar',
                            style: context.textStyles.textBold
                                .copyWith(color: Colors.red),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: widthButtonAction / 2,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            final valid =
                                formKey.currentState?.validate() ?? false;

                            if (valid) {
                              if (controller.imagePath == null) {
                                showWarning('Imagem obrigatória');
                                return;
                              }

                              controller.save(
                                nomeController.text,
                                UtilBrasilFields.converterMoedaParaDouble(
                                  precoController.text,
                                ),
                                descricaoController.text,
                              );
                            }
                          },
                          child: Text(
                            'Salvar',
                            style: context.textStyles.textBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
