import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { DistrictsService } from './districts.service';
import { CreateDistrictDto } from './dto/create-district.dto';
import { UpdateDistrictDto } from './dto/update-district.dto';

import { District as DistrictModel } from '@prisma/client';

@Controller('districts')
export class DistrictsController {
  constructor(private readonly districtsService: DistrictsService) {}

  // CREAR CIRCUNSCRIPCION
  @Post()
  async create(
    @Body() createDistrictDto: CreateDistrictDto,
  ): Promise<DistrictModel> {
    return this.districtsService.create(createDistrictDto);
  }

  // OBTENER TODAS LAS CIRCUNSCRIPCIONES
  @Get()
  findAll(): Promise<DistrictModel[]> {
    return this.districtsService.findAll({});
  }

  // OBTENER CIRCUNSCRIPCION POR ID
  @Get(':id')
  findOne(@Param('id') id: string): Promise<DistrictModel> {
    return this.districtsService.findOne({ id: Number(id) });
  }

  // EDITAR CIRCUNSCRIPCION
  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateDistrictDto: UpdateDistrictDto,
  ) {
    return this.districtsService.update(+id, updateDistrictDto);
  }

  // ELMINAR CIRCUNSCRIPCION
  @Delete(':id')
  remove(@Param('id') id: string): Promise<DistrictModel> {
    return this.districtsService.remove({ id: Number(id) });
  }
}
