import '../index.dart';

Widget customTextField({required TextEditingController controller,required String suffixIcon,required String fieldName} )=>Column(
  children: [
     Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Align(
          alignment: Alignment.centerLeft, child: Text(fieldName)),
    ),
        Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xffE2EAFC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter $fieldName",
            suffixIcon: Image.asset(
              "assets/images/$suffixIcon.png",
              width: 60,
            )),
        validator: (value) {
          // isValid(value, fieldName: "Username");
          if(value!.trim().isEmpty){
            return '$fieldName is required';
          }
          return null;
        },
      ),
    ),
  ],
);