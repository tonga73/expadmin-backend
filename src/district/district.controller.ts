import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Patch,
  Delete,
} from '@nestjs/common';
import { DistrictService } from './district.service';
import { District as DistrictModel } from '@prisma/client';

import { CreateDistrictDto } from './dto/create-district.dto';
import { UpdateDistrictDto } from './dto/update-district.dto';
@Controller()
export class DistrictController {
  constructor(private readonly districtService: DistrictService) {}

  // OBTENER TODAS LAS CIRCUNSCRIPCIONES
  @Get('districts')
  async getDistricts(): Promise<DistrictModel[]> {
    return this.districtService.districts({});
  }

  // OBTENER LA CIRCUNSCRIPCION POR ID
  @Get('district/:id')
  async getDistrictById(@Param('id') id: string): Promise<DistrictModel> {
    return this.districtService.district({ id: Number(id) });
  }

  // CREAR CIRCUNSCRIPCION
  @Post('district')
  async newDistrict(
    @Body()
    districtData: CreateDistrictDto,
  ): Promise<DistrictModel> {
    return this.districtService.createDistrict(districtData);
  }

  // EDITAR CIRCUNSCRIPCION
  @Patch('district/:id')
  async editDistrict(
    @Param('id') id: number,
    @Body() updateDistrictDto: UpdateDistrictDto,
  ): Promise<DistrictModel> {
    return this.districtService.updateDistrict(+id, updateDistrictDto);
  }

  // ELIMINAR CIRCUNSCRIPCION
  @Delete('district/:id')
  async removeDistrict(@Param('id') id: string): Promise<DistrictModel> {
    return this.districtService.deleteDistrict({ id: Number(id) });
  }
}
