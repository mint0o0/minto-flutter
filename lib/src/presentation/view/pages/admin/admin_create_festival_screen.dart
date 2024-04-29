import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/presentation/view_model/festival/festival_create_view_model.dart';

class AdminCreateFestivalScreen extends StatelessWidget {
  final FestivalCreateViewModel _festivalCreateViewModel =
      Get.put(FestivalCreateViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => _festivalCreateViewModel.festivalCreateModel
                  .update((val) => val!.name = value),
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              onChanged: (value) => _festivalCreateViewModel.festivalCreateModel
                  .update((val) => val!.startTime = value),
              decoration: const InputDecoration(labelText: 'Start Time'),
            ),
            TextField(
              onChanged: (value) => _festivalCreateViewModel.festivalCreateModel
                  .update((val) => val!.endTime = value),
              decoration: const InputDecoration(labelText: 'End Time'),
            ),
            // Todo: imageList 추가
            TextField(
              onChanged: (value) => _festivalCreateViewModel.festivalCreateModel
                  .update((val) => val!.location = value),
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextField(
              onChanged: (value) => _festivalCreateViewModel.festivalCreateModel
                  .update((val) => val!.description = value),
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            // Todo: missions 추가
            ElevatedButton(
              onPressed: () {
                _festivalCreateViewModel.createFestival(
                    _festivalCreateViewModel.festivalCreateModel.value);
              },
              child: const Text("Create Festival"),
            ),
          ],
        ),
      ),
    );
  }
}
