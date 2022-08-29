import { Body, Controller, Get, Post } from '@nestjs/common';
import { LocationService } from './location.service';
import { Location as LocationModel } from '@prisma/client';

@Controller()
export class LocationController {
  constructor(private readonly locationService: LocationService) {}

  // OBTENER TODAS LAS CIUDADES
  @Get('locations')
  async getLocations(): Promise<LocationModel[]> {
    return this.locationService.locations({});
  }

  // CREAR CIUDAD
  @Post('location')
  async newLocation(
    @Body() locationData: { name: string; court?: string },
  ): Promise<LocationModel> {
    return this.locationService.createLocation(locationData);
  }
}
