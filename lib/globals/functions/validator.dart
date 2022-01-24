String? isValid(value,{required fieldName}){
    if(value!.trim().isEmpty && value==null){
      return '$fieldName is required';
    }else{
      return null;
    }
}