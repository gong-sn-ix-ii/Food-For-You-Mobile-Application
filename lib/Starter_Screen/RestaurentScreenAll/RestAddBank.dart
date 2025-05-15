// ignore_for_file: unnecessary_import, file_names, implementation_imports, annotate_overrides, prefer_const_constructors, unnecessary_brace_in_string_interps, avoid_print, avoid_unnecessary_containers, non_constant_identifier_names, use_build_context_synchronously, unused_local_variable, must_be_immutable, prefer_final_fields, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/cospital_model.dart';
import 'package:foodapp/services/Database.dart';

class RestAddPay extends StatefulWidget {
  const RestAddPay({Key? key}) : super(key: key);

  @override
  State<RestAddPay> createState() => _RestAddPayState();
}

Database db = Database.instance;
String cospitalCurrency = "00", targetTodayCurrency = "00";

class _RestAddPayState extends State<RestAddPay> {
  updateCospitalAndTarget(int checkmode, String currency) {
    setState(() {
      print('Function Check ---> Currency == ##### ${currency} #####');
      print('Function Check ---> TextHint == ##### ${checkmode} #####');
      if (checkmode == 1) {
        cospitalCurrency = currency;
      } else if (checkmode == 2) {
        targetTodayCurrency = currency;
      }
    });
  }

  bool true_wallet = false, prompay = false, bitcoin = false;
  bool k_plus = false, paotung = false, paypaw = false;
  bool krungTH = false, shopeePay = false, masterCard = false;
  Future<void> setupPaybanks() async {
    CostpitalAndBankModel cos_banks = await db.get_CospitalAndBank();
    if (cos_banks != null) {
      cospitalCurrency = cos_banks.cost_start.toString();
      targetTodayCurrency = cos_banks.cost_target.toString();
      true_wallet = cos_banks.paybank["TrueWallet"]!;
      k_plus = cos_banks.paybank["KPlus"]!;
      krungTH = cos_banks.paybank["KrungThai"]!;
      prompay = cos_banks.paybank["PrompPay"]!;
      paotung = cos_banks.paybank["Paotung"]!;
      shopeePay = cos_banks.paybank["ShopeePay"]!;
      bitcoin = cos_banks.paybank["Bitcoin"]!;
      paypaw = cos_banks.paybank["PayPaw"]!;
      masterCard = cos_banks.paybank["MasterCard"]!;
    }
    print("Inistate ---===>>>${true_wallet}");
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await setupPaybanks();
      setState(() {});
    });
    super.initState();
    setState(() {});
  }

  @override
  // ignore: override_on_non_overriding_member
  final auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {
                print('Going To MainScreen Restaurant');
                Map<String, bool> paybank = {
                  "TrueWallet": true_wallet,
                  "KPlus": k_plus,
                  "KrungThai": krungTH,
                  "PrompPay": prompay,
                  "Paotung": paotung,
                  "ShopeePay": shopeePay,
                  "Bitcoin": bitcoin,
                  "PayPaw": paypaw,
                  "MasterCard": masterCard,
                };
                print('Going To MainScreen Restaurant');
                // Start Command
                CostpitalAndBankModel newcospital = CostpitalAndBankModel(
                    cost_start: cospitalCurrency,
                    cost_target: targetTodayCurrency,
                    paybank: paybank);
                print(
                    "Calling Database [Data ${paybank} | start ${newcospital.cost_start} | Target ${newcospital.cost_target}]");
                try {
                  db.add_CospitalAndBank(newcospital);
                } catch (err) {
                  print("Error ${err}");
                }
                // End Command
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => Main_ScreenRestaurant()),
                    (route) => false);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => Main_ScreenRestaurant()),
                    (route) => false);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: 20,
              ),
              label: Text('')),
        ),
        backgroundColor: Colors.black,
        title: Container(
          child: Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
              Text(
                '${auth.currentUser?.email}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            child: Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(65, 0, 0, 25)),
                Icon(
                  Icons.attach_money,
                  size: 20,
                  color: Colors.yellow,
                ),
                Text(
                  '00.00 THB',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(0),
        ),
      ),
      body: ListView(children: [
        Image(
          image: NetworkImage(
              "https://img.wongnai.com/p/1920x0/2018/05/24/3a0e2ec4c94d4902adcc4360b4ad719d.jpg"),
        ),
        SizedBox(
          height: 5,
        ),
        AspectRatio(
          aspectRatio: 7.5 / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 3.75 / 2,
                child: Card(
                  color: Color.fromARGB(255, 255, 140, 24),
                  elevation: 10,
                  child: InkWell(
                    splashColor: Colors.amber[100],
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 185,
                      height: 70,
                      child: Column(
                        children: [
                          Text(
                            'ค่าเฉลี่ย',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${cospitalCurrency} THB',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      print('Click Open AlertDialog');
                      showDialog(
                          context: context,
                          builder: (builder) => OpenAlertDialogCospital(
                              'Cospital', 1, updateCospitalAndTarget));
                    },
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 3.75 / 2,
                child: Card(
                  color: Color.fromARGB(255, 0, 255, 81),
                  elevation: 10,
                  child: InkWell(
                    splashColor: Colors.greenAccent[100],
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 185,
                      height: 70,
                      child: Column(
                        children: [
                          Text(
                            'ราคาสุทธิ',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${targetTodayCurrency} THB',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      print('Click Open AlertDialog');
                      showDialog(
                          context: context,
                          builder: (builder) => OpenAlertDialogCospital(
                              'TargetToday', 2, updateCospitalAndTarget));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(children: [
                Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.all(Colors.amber),
                    value: true_wallet,
                    onChanged: (bool? value) {
                      setState(() {
                        if (true_wallet != true) {
                          true_wallet = true;
                        } else {
                          true_wallet = false;
                        }
                      });
                    }),
                Material(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  //-----<True Wallet Logo>
                  child: InkWell(
                    splashColor: Colors.amber[50],
                    child: Ink.image(
                      image: NetworkImage(
                          'https://www.truemoney.com/wp-content/uploads/2020/11/logo-truemoneywallet-300x300-1.jpg'),
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width / 3.1,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      print('#### Check Bool = ${true_wallet}');
                      setState(() {
                        if (true_wallet != true) {
                          true_wallet = true;
                        } else {
                          true_wallet = false;
                        }
                      });
                    },
                  ),
                ),
                //-----<Prompay Logo>
                Checkbox(
                    activeColor: Colors.indigo,
                    fillColor: MaterialStateProperty.all(Colors.indigo),
                    checkColor: Colors.white,
                    value: prompay,
                    onChanged: (bool? value) {
                      setState(() {
                        if (prompay != true) {
                          prompay = true;
                        } else {
                          prompay = false;
                        }
                      });
                    }),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    splashColor: Colors.indigo[100],
                    child: Ink.image(
                      image: NetworkImage(
                          'https://www.finnomena.com/wp-content/uploads/2016/10/promt-pay-logo.jpg'),
                      height: MediaQuery.of(context).size.height / 16,
                      width: MediaQuery.of(context).size.width / 3.0,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      setState(() {
                        if (prompay != true) {
                          prompay = true;
                        } else {
                          prompay = false;
                        }
                      });
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                //-----<BTC Logo>
                Checkbox(
                    fillColor: MaterialStateProperty.all(Colors.orange[700]),
                    value: bitcoin,
                    onChanged: (bool? value) {
                      setState(() {
                        if (bitcoin != true) {
                          bitcoin = true;
                        } else {
                          bitcoin = false;
                        }
                      });
                    }),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    splashColor: Color.fromARGB(255, 255, 208, 133),
                    child: Ink.image(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEAgSDjas0tsn9GVE6BdpVkf8plXd4mi7N8Cv0_bGf9m2ZtxdJTpxTPpaoR4KPlrFmBnA&usqp=CAU'),
                      height: MediaQuery.of(context).size.height / 14,
                      width: MediaQuery.of(context).size.width / 7,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      setState(() {
                        if (bitcoin != true) {
                          bitcoin = true;
                        } else {
                          bitcoin = false;
                        }
                      });
                    },
                  ),
                ),
              ]),
              /*

               |---- <Line 2>----|

                */

              Column(
                children: [
                  Checkbox(
                      fillColor: MaterialStateProperty.all(Colors.green),
                      value: k_plus,
                      onChanged: (bool? value) {
                        setState(() {
                          if (k_plus != true) {
                            k_plus = true;
                          } else {
                            k_plus = false;
                          }
                        });
                      }),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      splashColor: Colors.green[50],
                      child: Ink.image(
                        image: NetworkImage(
                            'https://marketeeronline.co/wp-content/uploads/2018/10/TheDaily-K-Logo-new-K-PLUS-927x1024.jpg'),
                        height: MediaQuery.of(context).size.height / 10,
                        width: MediaQuery.of(context).size.width / 5,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        setState(() {
                          if (k_plus != true) {
                            k_plus = true;
                          } else {
                            k_plus = false;
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Checkbox(
                      fillColor: MaterialStateProperty.all(Colors.black),
                      value: paotung,
                      onChanged: (bool? value) {
                        setState(() {
                          if (paotung != true) {
                            paotung = true;
                          } else {
                            paotung = false;
                          }
                        });
                      }),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      splashColor: Colors.black12,
                      child: Ink.image(
                        image: NetworkImage(
                            'https://thejournalistclub.com/wp-content/uploads/2021/07/%E0%B8%84%E0%B8%99%E0%B8%A5%E0%B8%B0%E0%B8%84%E0%B8%A3%E0%B8%B6%E0%B9%88%E0%B8%87-696x415.jpg'),
                        height: MediaQuery.of(context).size.height / 11,
                        width: MediaQuery.of(context).size.width / 3,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        setState(() {
                          if (paotung != true) {
                            paotung = true;
                          } else {
                            paotung = false;
                          }
                        });
                      },
                    ),
                  ),
                  Checkbox(
                      fillColor: MaterialStateProperty.all(Colors.blue),
                      value: paypaw,
                      onChanged: (bool? value) {
                        setState(() {
                          setState(() {
                            if (paypaw != true) {
                              paypaw = true;
                            } else {
                              paypaw = false;
                            }
                          });
                        });
                      }),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      splashColor: Colors.blue[50],
                      child: Ink.image(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-ePrkdmfzHtmZjPbnEELZgFfLe0r8zha2Dh--evueckNW9VUPga4puiJFptPJMf5nbZs&usqp=CAU'),
                        height: MediaQuery.of(context).size.height / 16,
                        width: MediaQuery.of(context).size.width / 5,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        setState(() {
                          if (paypaw != true) {
                            paypaw = true;
                          } else {
                            paypaw = false;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              /*

               |---- <Line 3>----|

                */
              Column(
                children: [
                  Checkbox(
                      value: krungTH,
                      onChanged: (bool? value) {
                        setState(() {
                          if (krungTH != true) {
                            krungTH = true;
                          } else {
                            krungTH = false;
                          }
                        });
                      }),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      splashColor: Colors.blue[50],
                      child: Ink.image(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUjW1gx-C1RhDwGYZ7PqDoDQUDQ38MuPh5mHhFfh5eovuud950Ph02fievl2GkyqLoz_s&usqp=CAU'),
                        height: MediaQuery.of(context).size.height / 10,
                        width: MediaQuery.of(context).size.width / 5,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        setState(() {
                          if (krungTH != true) {
                            krungTH = true;
                          } else {
                            krungTH = false;
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Checkbox(
                      fillColor: MaterialStateProperty.all(Colors.deepOrange),
                      checkColor: Colors.white,
                      value: shopeePay,
                      onChanged: (bool? value) {
                        setState(() {
                          if (shopeePay != true) {
                            shopeePay = true;
                          } else {
                            shopeePay = false;
                          }
                        });
                      }),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      splashColor: Colors.deepOrangeAccent[100],
                      child: Ink.image(
                        image: NetworkImage(
                            'https://play-lh.googleusercontent.com/oXs9tsmauo4_xFDsovB7i3ONfNWZ9FR8shrnegcYC4tHCjybZexXa0fpe9N_3kYqw-U=w240-h480-rw'),
                        height: MediaQuery.of(context).size.height / 11,
                        width: MediaQuery.of(context).size.width / 6,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        setState(() {
                          if (shopeePay != true) {
                            shopeePay = true;
                          } else {
                            shopeePay = false;
                          }
                        });
                      },
                    ),
                  ),
                  Checkbox(
                      fillColor: MaterialStateProperty.all(Colors.yellow[400]),
                      value: masterCard,
                      checkColor: Colors.indigo,
                      onChanged: (bool? value) {
                        setState(() {
                          if (masterCard != true) {
                            masterCard = true;
                          } else {
                            masterCard = false;
                          }
                        });
                      }),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      splashColor: Colors.yellow[50],
                      child: Ink.image(
                        image: NetworkImage(
                            'https://www.mentarimulia.co.id/wp-content/uploads/2021/04/saham-cfd-mastercard.png'),
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width / 5,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        setState(() {
                          if (masterCard != true) {
                            masterCard = true;
                          } else {
                            masterCard = false;
                          }
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ), /////////////
      ]),
    );
  }
}

class OpenAlertDialogCospital extends StatefulWidget {
  String _cospitalAndTarget;
  int checkMode;
  Function updateCospitalAndTarget;
  OpenAlertDialogCospital(
      this._cospitalAndTarget, this.checkMode, this.updateCospitalAndTarget);
  @override
  State<OpenAlertDialogCospital> createState() =>
      _OpenAlertDialogCospitalState();
}

class _OpenAlertDialogCospitalState extends State<OpenAlertDialogCospital> {
  @override
  Widget build(BuildContext context) {
    int checkingMode = widget.checkMode;
    TextEditingController _controller = TextEditingController();
    String textHint;

    if (widget._cospitalAndTarget == 'Cospital') {
      textHint = 'ต้นทุนต่อวัน';
      checkingMode = 1;
    } else if (widget._cospitalAndTarget == 'TargetToday') {
      textHint = 'เป้าหมายต่อวัน';
      checkingMode = 2;
    } else {
      textHint = 'ต้นทุน และ เป้าหมาย';
    }
    return ListView(
      padding: EdgeInsets.fromLTRB(0, 200, 0, 200),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              content: TextFormField(
                maxLength: 7,
                keyboardType: TextInputType.numberWithOptions(),
                controller: _controller,
                decoration: InputDecoration(
                  hintText: textHint,
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 2)),
                  disabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_controller.text == '' || _controller.text == null) {
                        _controller.text += '00.00';
                      } else {
                        _controller.text += '.00';
                      }

                      print('TextHint == ##### ${textHint} #####');
                      print('TextHint == ##### ${checkingMode} #####');
                      print('TextHint == ##### ${_controller.text} #####');
                      widget.updateCospitalAndTarget(
                          checkingMode, _controller.text);
                      _controller.clear();
                      Navigator.pop(context, 'Accept');
                    });
                  },
                  child: Text(
                    'ยืนยัน',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 0, 255, 8))),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'Accept'),
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 255, 0, 0))),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
