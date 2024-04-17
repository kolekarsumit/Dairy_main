import 'package:dairy/Admin/Admin_pannel/Admin_View.dart';
import 'package:dairy/Admin/Admin_pannel/machine_model.dart';
import 'package:flutter/material.dart';

class PinCodeWidget extends StatefulWidget {
  Function(MachineInfo) callback;
   PinCodeWidget({required this.callback});

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  String correctPassword = '1234';
  String enteredPin = '';
  bool isPinVisible = false;

  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (enteredPin.length < 4) {
              enteredPin += number.toString();
            }
          });
        },
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void checkPasswordAndNavigate(BuildContext context) {
    if (enteredPin == correctPassword) {
      // Password is correct, navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminView(
          callback: (info){
            widget.callback(info);
          },
        )),
      );
    } else {
      // Password is incorrect, show error message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Incorrect password. Please try again.',
              style: TextStyle(
                fontFamily: 'bolt-regular.ttf',
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
            margin: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          physics: const BouncingScrollPhysics(),
          children: [
            const Center(
              child: Text(
                'Enter Your Password',
                style: TextStyle(
                  fontFamily: 'bolt-regular.ttf',
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                    (index) {
                  return Container(
                    margin: const EdgeInsets.all(6.0),
                    width: isPinVisible ? 50 : 16,
                    height: isPinVisible ? 50 : 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: index < enteredPin.length
                          ? isPinVisible
                          ? Colors.green
                          : Colors.blue
                          : Colors.blue.withOpacity(0.1),
                    ),
                    child: isPinVisible && index < enteredPin.length
                        ? Center(
                      child: Text(
                        enteredPin[index],
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                        : null,
                  );
                },
              ),
            ),

            IconButton(
              onPressed: () {
                setState(() {
                  isPinVisible = !isPinVisible;
                });

              },
              icon: Icon(
                isPinVisible ? Icons.visibility_off : Icons.visibility,
              ),
            ),

            SizedBox(height: isPinVisible ? 50.0 : 8.0),

            for (var i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                        (index) => numButton(1 + 3 * i + index),
                  ).toList(),
                ),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextButton(onPressed: null, child: SizedBox()),
                  numButton(0),
                  TextButton(
                    onPressed: () {
                      setState(
                            () {
                          if (enteredPin.isNotEmpty) {
                            enteredPin = enteredPin.substring(
                                0, enteredPin.length - 1);
                          }
                        },
                      );
                    },
                    child: const Icon(
                      Icons.backspace,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    checkPasswordAndNavigate(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: BorderSide(color: Colors.blue),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Border radius
                    ),
                  ),
                  child: Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

