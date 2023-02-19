import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/admin/screens/utilities/utils.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/admin/services/storage_service.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:uuid/uuid.dart';

class AdminCreateNewProduct extends StatefulWidget {
  const AdminCreateNewProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminCreateNewProduct> createState() => AdminCreateNewProductState();
}

class AdminCreateNewProductState extends State<AdminCreateNewProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController overPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  quill.QuillController _descriptionController = quill.QuillController.basic();
  // quillController = quill.QuillController.basic();

  bool? setStatus = true;
  XFile? imagePicked;
  String? imageUrl;
  final formKey = GlobalKey<FormState>();
  bool upload = false;

  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();
  final ProductsController _productsController = Get.find();
  @override
  void initState() {
    // quill.DefaultTextBlockStyle(
    //   const TextStyle(fontFamily: 'Cairo'),
    //   const Tuple2<double, double>(6, 0),
    //   const Tuple2<double, double>(6, 0),
    //   const BoxDecoration(),
    // );
    // const quill.DirectionAttribute('rtl');
    // const quill.DirectionAttribute('right');
    //_descriptionController.formatText(0, 10,
    // const quill.Attribute('align', quill.AttributeScope.IGNORE, 'right'));

    if (_productsController.newProduct['description'] != null) {
      _descriptionController = quill.QuillController(
        document: quill.Document.fromJson(
            _productsController.newProduct['description']),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    setStatus = _productsController.newProduct['status'] ?? true;
    imageUrl = _productsController.newProduct['image'];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: MyColors.lessBlackColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Container(
            margin: const EdgeInsets.all(20),
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
            decoration: BoxDecoration(
              color: MyColors.bg,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    '  منتج جديد',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                _builderTextFiel(
                                  name: 'name',
                                  numLine: 1,
                                  hintText: '  اسم المنتج',
                                  productsController: _productsController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'الحالة',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 14,
                                          color: MyColors.secondaryTextColor),
                                    ),
                                    Checkbox(
                                      activeColor: MyColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      value: setStatus,
                                      onChanged: ((value) {
                                        if (_productsController
                                            .newProduct.isNotEmpty) {
                                          _productsController.newProduct.update(
                                              'status', (value) => value,
                                              ifAbsent: (() => value));
                                        }

                                        setState(() {
                                          setStatus = value;
                                        });
                                      }),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: _builderTextFiel(
                                        name: 'quantity',
                                        hintText: 'الكمية',
                                        numLine: 1,
                                        productsController: _productsController,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),

                        //
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //color: MyColors.secondaryColor,
                          ),
                          width: 100,
                          height: 100,
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: AlignmentDirectional.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: imagePicked == null
                                    ? imageUrl == null
                                        ? Container(
                                            color: MyColors.secondaryColor,
                                          )
                                        : Image.network(
                                            imageUrl!,
                                            fit: BoxFit.cover,
                                            width: double.maxFinite,
                                          )
                                    : Image.file(
                                        File(imagePicked!.path),
                                        fit: BoxFit.cover,
                                        width: double.maxFinite,
                                      ),
                              ),
                              InkWell(
                                radius: 10,
                                onTap: () async {
                                  final imagePicker = ImagePicker();
                                  XFile? image = await imagePicker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (image == null) return;
                                  setState(() {
                                    imagePicked = image;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    // color: MyColors.secondaryColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.circlePlus,
                                    size: 25,
                                    color:
                                        MyColors.primaryColor.withOpacity(0.5),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //price
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _builderTextFiel(
                          name: 'offerPrice',
                          hintText: 'السعر القديم',
                          numLine: 1,
                          productsController: _productsController,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: _builderTextFiel(
                          name: 'price',
                          hintText: 'السعر',
                          numLine: 1,
                          productsController: _productsController,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // description
                  Row(
                    children: const [
                      Spacer(),
                      Text(
                        'وصف المنتج',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: MyColors.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //text erea
                  Container(
                    padding: const EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.containerColor,
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 300,
                    child: Column(
                      children: [
                        quill.QuillToolbar.basic(
                          showDirection: true,
                          showRightAlignment: true,
                          showLeftAlignment: true,
                          showAlignmentButtons: true,
                          fontFamilyValues: const {'cairo': 'Cairo'},
                          fontSizeValues: const {
                            'Very Small': '8',
                            'Small': '12',
                            'Medium': '14',
                            'Large': '16',
                            'veryLarg': '18',
                            'Clear': '0'
                          },
                          multiRowsDisplay: true,
                          controller: _descriptionController,
                          showBackgroundColorButton: true,
                          toolbarSectionSpacing: 10,
                          toolbarIconSize: 20,
                          iconTheme: const quill.QuillIconTheme(
                            borderRadius: 10,
                            iconUnselectedFillColor: MyColors.containerColor,
                            iconSelectedFillColor: MyColors.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 600),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: MyColors.containerColor,
                                width: 2,
                              ),
                              color: MyColors.bg,
                            ),
                            child: quill.QuillEditor.basic(
                              controller: _descriptionController,
                              readOnly: false,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // uploading new product
                  const SizedBox(
                    height: 20,
                  ),
                  if (_productsController.upload.value)
                    Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.secondaryColor,
                        ),
                        child: const SizedBox(
                            height: 40,
                            width: 40,
                            child: Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 3,
                              backgroundColor: Colors.white,
                              color: MyColors.primaryColor,
                            )))),
                  //  const FaIcon(FontAwesomeIcons),
                  if (!_productsController.upload.value)
                    ElevatedButton.icon(
                        onPressed: () async {
                          final description = _descriptionController.document
                              .toDelta()
                              .toJson();
                          if (imageUrl != null) {
                            _productsController.upload.value = true;
                            if (imagePicked != null) {
                              await storage.uploadImage(
                                  imagePicked!, 'products_images');

                              await _productsController.deleteImage(
                                  _productsController.newProduct['image']);
                              final imageName = await storage.getDownloadURL(
                                  imagePicked!.name, 'products_images');
                              _productsController.newProduct.update(
                                  'image', (_) => imageName,
                                  ifAbsent: () => imageName);
                            }
                            var updatedProduct = Product(
                              id: _productsController.newProduct['id'],
                              name: _productsController.newProduct['name'],
                              description: description,
                              image: _productsController.newProduct['image'],
                              price: _productsController.newProduct['price'],
                              offerPrice:
                                  _productsController.newProduct['offerPrice'],
                              quantity:
                                  _productsController.newProduct['quantity'],
                              cid: _productsController.newProduct['cid'],
                              status: setStatus ??
                                  _productsController.newProduct['status'],
                              createAt:
                                  _productsController.newProduct['createAt'],
                            );

                            if (updatedProduct.name.isNotEmpty &&
                                updatedProduct.description.isNotEmpty &&
                                updatedProduct.image.isNotEmpty &&
                                updatedProduct.price.isNotEmpty) {
                              _productsController
                                  .updateDocument(updatedProduct);
                            } else {
                              Utils.showSnackBar('ادخل كل المعتومات المطلوبه');
                            }
                            _productsController.upload.value = false;
                            _descriptionController.clear();
                            Get.back();
                            Get.defaultDialog(
                                title: '',
                                // backgroundColor: MyColors.bg.withOpacity(0.2),
                                content: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'تم التعديل بنجاح',
                                        style: TextStyle(
                                          color: MyColors.secondaryTextColor,
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        // width: 50,height: 50,

                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.green),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          size: 35,
                                          color: Colors.green,
                                        ),
                                      )
                                    ],
                                  )),
                                ));
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) => Get.back());
                            return;
                          }
                          var newProduct = _productsController.newProduct;

                          if (newProduct['name'] == null &&
                              newProduct['price'] == null &&
                              imagePicked == null &&
                              newProduct['quantity'] == null) return;
                          _productsController.upload.value = true;
                          

                            Product? lastProduct =
                                          await database.getLastIdForProducts();
                                      String lastId = '0';
                                      if (lastProduct != null) {
                                        lastId = lastProduct.id;
                                      }
                                      String id =
                                          (int.parse(lastId) + 1).toString();
                          

                          try {
                            await storage.uploadImage(
                                imagePicked!, 'products_images');
                            newProduct['image'] = await storage.getDownloadURL(
                                imagePicked!.name, 'products_images');

                            final product = Product(
                              id: id,
                              name: newProduct['name'],
                              description: description,
                              image: newProduct['image'],
                              price: newProduct['price'],
                              offerPrice: newProduct['offerPrice'],
                              quantity: newProduct['quantity'],
                              status: setStatus ?? false,
                              cid: _productsController.categoryId.value,
                              createAt: DateTime.now(),
                            );
                            // print(product);
                            _productsController.newProduct.clear();

                            await _productsController.addProduct(product);
                            _descriptionController.clear();
                          } catch (e) {
                            _productsController.upload.value = false;
                          } finally {
                            Get.defaultDialog(
                                title: '',
                                // backgroundColor: MyColors.bg.withOpacity(0.2),
                                content: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'تم التعديل بنجاح',
                                        style: TextStyle(
                                          color: MyColors.secondaryTextColor,
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        // width: 50,height: 50,

                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.green),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          size: 35,
                                          color: Colors.green,
                                        ),
                                      )
                                    ],
                                  )),
                                ));
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) => Get.back());

                            _productsController.upload.value = false;
                            _descriptionController.clear();
                            Get.back();
                          }
                        },
                        icon: const FaIcon(FontAwesomeIcons.plus),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(55),
                          backgroundColor: MyColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        label: const Text(
                          'اضافه',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                        ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _builderTextFiel extends StatelessWidget {
  final String name;
  final String hintText;
  ProductsController productsController;
  final int numLine;
  _builderTextFiel({
    Key? key,
    required this.name,
    required this.hintText,
    required this.numLine,
    required this.productsController,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        initialValue: productsController.newProduct[name] ?? '',
        onChanged: ((value) {
          productsController.newProduct.update(
            name,
            (_) => value,
            ifAbsent: () => value,
          );
        }),
        //textInputAction: TextInputAction.next,
        // onEditingComplete: () => FocusScope.of(context).nextFocus(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (name) => name == null ? "الحقل فاضي" : null,
        minLines: numLine,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: MyColors.secondaryTextColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
          errorStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            color: Colors.red,
          ),
          hintStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            color: MyColors.secondaryTextColor,
          ),
        ),
        style: const TextStyle(
          color: MyColors.blackColor,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
