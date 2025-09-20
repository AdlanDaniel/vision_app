// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';
import 'package:vision_app/features/profile/models/plan_model.dart';

import 'package:vision_app/features/profile/repository/profile_repository.dart';

part 'detail_plan_controller.g.dart';

class DetailPlanController = DetailPlanControllerBase with _$DetailPlanController;

abstract class DetailPlanControllerBase with Store {
   final ProfileRepository _profileRepository;
  DetailPlanControllerBase(
     this._profileRepository,
  );

   @observable
  PlanModel plans = PlanModel(
    id: 1,
    name: 'Plan Basic',
    description: 'Access to movies in SD quality',
    price: 19.90,
    dueDate: DateTime.now().add(const Duration(days: 30)),
    benefits: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ],
  );

}
