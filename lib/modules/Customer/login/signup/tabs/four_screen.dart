import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myshoop/modules/Customer/login/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/login/cubit/state.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';

class FourScreen extends StatelessWidget {
  const FourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (ctx, state) {
        final image = LoginCubit.get(context).imagee;
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(mytranslate(context, "hintfour")),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              LoginCubit.get(context).getImageBloc(ImageSource.gallery);
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.65,
              decoration: BoxDecoration(
                  color: myBlacks, borderRadius: BorderRadius.circular(30.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      mytranslate(context, "gallery"),
                      style: TextStyle(
                          color: myWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    MdiIcons.cameraAccount,
                    size: 35,
                    color: myWhite,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          if (image != null)
            Expanded(
                child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: double.infinity,
                  child: Image(
                    image: FileImage(image),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      LoginCubit.get(context).deleteImageBlocLogin();
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: HexColor('#C18F3A'),
                      size: 20,
                    )),
                // ignore: unnecessary_null_comparison
              ],
            ))
        ]);
      },
    );
  }
}
