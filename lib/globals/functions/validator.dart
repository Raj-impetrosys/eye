String? isValid(value,{required fieldName}){
    if(value!.trim().isEmpty){
      return '$fieldName is required';
    }
      return null;
}